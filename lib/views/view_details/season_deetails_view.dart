/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/controllers/season_details_controller.dart';

class SeasonDetailsView extends StatelessWidget {
  final int tvShowId;
  final int seasonNumber;
  final String seasonName;

  SeasonDetailsView({
    required this.tvShowId,
    required this.seasonNumber,
    required this.seasonName,
  });

  final SeasonDetailsController controller =
      Get.put(SeasonDetailsController());

  @override
  Widget build(BuildContext context) {
    controller.fetchSeasonDetails(tvShowId, seasonNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(seasonName, style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0B102F),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: const Color(0xFF0B102F),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.episodes.isEmpty) {
          return Center(
            child: Text("لا توجد حلقات متاحة",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: controller.episodes.length,
          itemBuilder: (context, index) {
            final episode = controller.episodes[index];
            return Card(
              color: Color(0xFF1C1F3D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w200${episode.stillPath}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  "${episode.episodeNumber}. ${episode.name}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                subtitle: Text(
                  episode.overview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                onTap: () {
                  // يمكن هنا فتح صفحة تفاصيل الحلقة إذا أردت
                },
              ),
            );
          },
        );
      }),
    );
  }
}
*/