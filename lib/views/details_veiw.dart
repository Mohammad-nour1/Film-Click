import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/controllers/details_controller.dart';
import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/models/tv_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsView extends StatelessWidget {
  final DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    final Movie? movie =
        controller.movie.value.id != 0 ? controller.movie.value : null;
    final TvShow? tvShow =
        controller.tvShow.value.id != 0 ? controller.tvShow.value : null;

    return Scaffold(
      backgroundColor: Color(0xFF0B102F), // لون الخلفية
      appBar: AppBar(
        backgroundColor: Color(0xFF0B102F),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
                    // عرض صورة خلفية
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        movie != null
                            ? "https://image.tmdb.org/t/p/original/${movie.backdropPath}"
                            : "https://image.tmdb.org/t/p/original/${tvShow?.backdropPath}",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),

                    // عنوان الفيلم أو المسلسل
                    Text(
                      movie != null ? movie.title : tvShow?.name ?? '',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),

                    // عرض الوصف
                    Text(
                      movie != null ? movie.overview : tvShow?.overview ?? '',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 16),

                    // عرض التفاصيل الأخرى للفيلم أو المسلسل
                    if (movie != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 8),
                              Text("Release Date: ${movie.releaseDate}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 16),
                              SizedBox(width: 8),
                              Text("Rating: ${movie.voteAverage}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ],
                      )
                    else if (tvShow != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 8),
                              Text("First Air Date: ${tvShow.firstAirDate}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 16),
                              SizedBox(width: 8),
                              Text("Rating: ${tvShow.voteAverage}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    SizedBox(height: 16),

                    // أزرار Watch Trailer و Watch Movie بجانب بعضهما
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // زر عرض التريلر
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(126, 54, 255, 218),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            shadowColor: const Color.fromARGB(255, 5, 237, 245),
                            elevation: 10,
                          ),
                          onPressed: () {
                            controller.fetchVideos(movie?.id ?? tvShow!.id,
                                isMovie: movie != null);
                            showTrailer(context);
                          },
                          icon: Icon(Icons.play_circle, color: Colors.white),
                          label: Text('Watch Trailer',
                              style: TextStyle(color: Colors.white)),
                        ),

                        // زر عرض الفيديو الرئيسي (للفيلم)
                        if (movie != null)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(126, 54, 255, 218),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor:
                                  const Color.fromARGB(255, 5, 237, 245),
                              elevation: 10,
                            ),
                            onPressed: () {
                              controller.fetchVideos(movie.id, isMovie: true);
                              showTrailer(context, isMainVideo: true);
                            },
                            icon: Icon(Icons.movie, color: Colors.white),
                            label: Text('Watch Movie',
                                style: TextStyle(color: Colors.white)),
                          ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // زر إضافة إلى المفضلة
                    Obx(() {
                      final isFavorite = controller.isFavorite.value;
                      return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFavorite
                              ? Colors.red
                              : Color.fromARGB(126, 54, 255, 218),
                          padding: EdgeInsets.symmetric(
                              horizontal: 120, vertical: 8),
                              
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadowColor: const Color.fromARGB(255, 5, 237, 245),
                          elevation: 10,
                        ),
                        onPressed: () {
                          controller.toggleFavorite(movie?.id ?? tvShow!.id);
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        label: Text(
                          isFavorite
                              ? 'Remove from Favorites'
                              : 'Add to Favorites',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    // عرض الحلقات والأجزاء (للمسلسلات فقط)
                    if (tvShow != null) buildSeasonsList(),

                    // عرض قائمة الممثلين
                    buildCastList(),
                  ],
                ),
              )
            : Center(
                child: Text('No details available',
                    style: TextStyle(color: Colors.white))),
      ),
    );
  }

  void showTrailer(BuildContext context, {bool isMainVideo = false}) {
    final videoKey = isMainVideo
        ? controller.mainVideoKey.value
        : controller.trailerVideoKey.value;
    if (videoKey.isEmpty) {
      Get.snackbar("Error", "No video available");
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
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seasons',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tvShow.seasons.length,
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
        Text('Cast',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Obx(() {
          final cast = controller.cast.value;
          if (cast.isEmpty) {
            return Text('No cast available',
                style: TextStyle(color: Colors.white70));
          }
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
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
