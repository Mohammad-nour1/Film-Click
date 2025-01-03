import 'package:filmclick/models/tv_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/controllers/details_controller.dart';
import 'package:filmclick/models/movie_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsView extends StatelessWidget {
  final DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    final Movie? movie = controller.movie.value.id != 0 ? controller.movie.value : null;
    final TvShow? tvShow = controller.tvShow.value.id != 0 ? controller.tvShow.value : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie != null ? movie.title : tvShow?.name ?? 'Details'),
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
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),

                    // عرض الوصف
                    Text(
                      movie != null ? movie.overview : tvShow?.overview ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),

                    // عرض التفاصيل الأخرى للفيلم أو المسلسل
                    if (movie != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Release Date: ${movie.releaseDate}", style: TextStyle(fontSize: 16)),
                          Text("Rating: ${movie.voteAverage}", style: TextStyle(fontSize: 16)),
                        ],
                      )
                    else if (tvShow != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("First Air Date: ${tvShow.firstAirDate}", style: TextStyle(fontSize: 16)),
                          Text("Rating: ${tvShow.voteAverage}", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    SizedBox(height: 16),

                    // زر عرض التريلر
                    ElevatedButton.icon(
                      onPressed: () {
                        controller.fetchVideos(movie?.id ?? tvShow!.id, isMovie: movie != null);
                        showTrailer(context);  // عرض التريلر
                      },
                      icon: Icon(Icons.play_circle),
                      label: Text('Watch Trailer'),
                    ),

                    // زر عرض الفيديو الرئيسي (للفيلم)
                    if (movie != null)
                      ElevatedButton.icon(
                        onPressed: () {
                          controller.fetchVideos(movie.id, isMovie: true); // استدعاء fetchVideos لجلب الفيديو الرئيسي
                          showTrailer(context, isMainVideo: true);  // عرض الفيديو الرئيسي
                        },
                        icon: Icon(Icons.movie),
                        label: Text('Watch Movie'),
                      ),

                    // عرض الحلقات والأجزاء (للمسلسلات فقط)
                    if (tvShow != null) buildSeasonsList(),

                    // عرض قائمة الممثلين
                    buildCastList(),
                  ],
                ),
              )
            : Center(child: Text('No details available')),
      ),
    );
  }

  // دالة عرض التريلر باستخدام YouTubePlayer
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

  // دالة عرض الحلقات والأجزاء
  Widget buildSeasonsList() {
    final tvShow = controller.tvShow.value;
    if (tvShow.seasons.isEmpty) {
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seasons', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              title: Text(season.name),
              subtitle: Text("Episodes: ${season.episodeCount}"),
              onTap: () {
                // فتح صفحة الحلقات (يمكنك تحسينها لاحقًا)
              },
            );
          },
        ),
      ],
    );
  }

  // دالة عرض الممثلين
  Widget buildCastList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cast', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Obx(() {
          final cast = controller.cast.value;
          if (cast.isEmpty) {
            return Text('No cast available');
          }
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (context, index) {
                final actor = cast[index];
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://image.tmdb.org/t/p/w200${actor['profile_path']}",
                      ),
                      radius: 40,
                    ),
                    Text(actor['name']),
                  ],
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
