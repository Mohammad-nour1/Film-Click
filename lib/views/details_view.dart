import 'package:filmclick/controllers/home_controller.dart';
import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/controllers/details_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsView extends StatelessWidget {
  final DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    final Movie? movie =
        controller.movie.value.id != 0 ? controller.movie.value : null;
    final TvShow? tvShow =
        controller.tvShow.value.id != 0 ? controller.tvShow.value : null;

    return WillPopScope(
      onWillPop: () async {
        final homeController = Get.find<HomeController>();
        Get.toNamed("/home"); // العودة إلى الصفحة الرئيسية
        homeController.refreshData();
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0B102F),
        appBar: AppBar(
          backgroundColor: Color(0xFF0B102F),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              final homeController = Get.find<HomeController>();
              homeController.refreshData();
              Get.toNamed("/home");
            },
          ),
          title: Text(
            movie != null ? movie.title : tvShow?.name ?? 'Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: movie != null || tvShow != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          movie != null
                              ? "https://image.tmdb.org/t/p/original/${movie.backdropPath}"
                              : "https://image.tmdb.org/t/p/original/${tvShow?.backdropPath}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        movie != null ? movie.title : tvShow?.name ?? '',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        movie != null ? movie.overview : tvShow?.overview ?? '',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 16),
                      movie != null
                          ? buildMovieDetails(movie)
                          : buildTvShowDetails(tvShow),
                      SizedBox(height: 16),
                      buildButtons(movie, tvShow, context),
                      SizedBox(height: 16),
                      Obx(() {
                        final isFavorite = controller.isFavorite.value;
                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFavorite
                                ? Colors.red
                                : Color.fromARGB(126, 54, 255, 218),
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width *
                                  0.335, // استخدم النسبة لتحديد العرض بناءً على حجم الشاشة
                              vertical: 9,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            shadowColor: const Color.fromARGB(255, 5, 237, 245),
                            elevation: 9,
                          ),
                          onPressed: () {
                            controller.toggleFavorite(movie?.id ?? tvShow!.id);
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          label: Text(
                            isFavorite ? 'Remove from Favorite' : 'Favorite',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      if (tvShow != null) buildSeasonsList(),
                      buildCastList(),
                    ],
                  ),
                )
              : Center(
                  child: Text('No details available',
                      style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }

  Widget buildMovieDetails(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDetailRow(Icons.date_range, "Release Date: ${movie.releaseDate}"),
        SizedBox(height: 8),
        buildDetailRow(Icons.star, "Rating: ${movie.voteAverage}"),
      ],
    );
  }

  Widget buildTvShowDetails(TvShow? tvShow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDetailRow(
            Icons.date_range, "First Air Date: ${tvShow?.firstAirDate}"),
        SizedBox(height: 8),
        buildDetailRow(Icons.star, "Rating: ${tvShow?.voteAverage}"),
      ],
    );
  }

  Widget buildDetailRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 16),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }

  Widget buildButtons(Movie? movie, TvShow? tvShow, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(126, 54, 255, 218),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width *
                  0.286, // استخدم النسبة لتحديد العرض بناءً على حجم الشاشة
              vertical: 9,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            shadowColor: const Color.fromARGB(255, 5, 237, 245),
            elevation: 9,
          ),
          onPressed: () {
            controller.fetchVideos(movie?.id ?? tvShow!.id,
                isMovie: movie != null);
            showTrailer(context);
          },
          icon: Icon(Icons.play_circle, color: Colors.white),
          label: Text('Watch Trailer', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void showTrailer(BuildContext context, {bool isMainVideo = false}) {
    final videoKey = isMainVideo
        ? controller.mainVideoKey.value
        : controller.trailerVideoKey.value;
    if (videoKey.isEmpty) {
      Get.snackbar(
          "No Video", "Unfortunately, no trailer or video is available.");
      return;
    }
    Get.dialog(
      Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoKey,
            flags: YoutubePlayerFlags(autoPlay: true),
          ),
        ),
      ),
    );
  }

  Widget buildSeasonsList() {
    final tvShow = controller.tvShow.value;
    if (tvShow.seasons.isEmpty) {
      return Center(
          child: Text('No seasons available',
              style: TextStyle(color: Colors.white)));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seasons',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tvShow.seasons.length,
          separatorBuilder: (context, index) => Divider(color: Colors.white),
          itemBuilder: (context, index) {
            final season = tvShow.seasons[index];
            return ListTile(
              leading: Image.network(
                "https://image.tmdb.org/t/p/w200${season.posterPath}",
                width: 50,
              ),
              title: Text(season.name, style: TextStyle(color: Colors.white)),
              subtitle: Text("Episodes: ${season.episodeCount}",
                  style: TextStyle(color: Colors.white70)),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }

  Widget buildCastList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cast',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Obx(() {
          final cast = controller.cast.value;
          if (cast.isEmpty) {
            return Text('No cast available',
                style: TextStyle(color: Colors.white70));
          }
          return SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.white),
              itemBuilder: (context, index) {
                final actor = cast[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://image.tmdb.org/t/p/w200${actor['profile_path']}",
                        ),
                        radius: 40,
                      ),
                      Text(actor['name'],
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
