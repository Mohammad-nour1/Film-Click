import 'package:filmclick/controllers/tv_show_controller.dart';
import 'package:filmclick/views/view_details/tvshow_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvShowsView extends StatelessWidget {
  final TvShowsController tvShowsController =
      Get.put(TvShowsController()); // استخدام الـ Controller الخاص بالمسلسلات

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tv Shows", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 11, 16, 47),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 11, 16, 47),
      body: Obx(() {
        if (tvShowsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (tvShowsController.tvShows.isEmpty) {
          return Center(
            child: Text(
              "لا توجد مسلسلات حالياً",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          // جعل الصفحة قابلة للتمرير عموديًا
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Wrap(
              spacing: 45, // المسافة بين العناصر أفقيًا
              runSpacing: 10, // المسافة بين الصفوف
              alignment: WrapAlignment.center,
              children: tvShowsController.tvShows.map((tvShow) {
                return GestureDetector(
                  onTap: () {
                    // تابع الضغط على الصورة هنا
                 
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${tvShow.posterPath}",
                          height: 200, // زيادة الطول
                          width: 130, // زيادة العرض
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 130, // لضمان عدم تمدد النص أكثر من الصورة
                        child: Text(
                          tvShow.name,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}
