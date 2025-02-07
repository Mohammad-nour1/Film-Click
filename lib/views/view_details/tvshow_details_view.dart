import 'package:filmclick/controllers/tv_show_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvShowDetailsView extends StatelessWidget {
  final TvShowDetailsController controller = Get.put(TvShowDetailsController());

  @override
  Widget build(BuildContext context) {
    final int tvShowId = Get.arguments['tvShowId'];
    controller.fetchTvShowDetails(tvShowId);
    
    return Scaffold(
      backgroundColor: Color(0xFF0B102F),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B102F),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
              controller.tvShow.value?.name ?? 'تفاصيل المسلسل',
              style: TextStyle(color: Colors.white),
            )),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        
        final tvShow = controller.tvShow.value;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "https://image.tmdb.org/t/p/original/${tvShow?.backdropPath}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  tvShow?.name ?? '',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  tvShow?.overview ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'المواسم',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8),
              buildSeasonsList(),
            ],
          ),
        );
      }),
    );
  }

  Widget buildSeasonsList() {
    return Obx(() {
      final seasons = controller.tvShow.value?.seasons;
      if (seasons!.isEmpty) {
        return Center(
            child: Text('لا توجد مواسم متاحة',
                style: TextStyle(color: Colors.white70)));
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: seasons.length,
        itemBuilder: (context, index) {
          final season = seasons[index];
          return ListTile(
            leading: Image.network(
              "https://image.tmdb.org/t/p/w200${season.posterPath}",
              width: 50,
            ),
            title: Text(season.name, style: TextStyle(color: Colors.white)),
            subtitle: Text("الحلقات: ${season.episodeCount}",
                style: TextStyle(color: Colors.white70)),
            onTap: () {
},

          );
        },
      );
    });
  }
}
