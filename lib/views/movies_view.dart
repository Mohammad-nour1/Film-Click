import 'package:filmclick/controllers/movie_controller.dart';
import 'package:filmclick/views/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesView extends StatelessWidget {
  final MoviesController moviesController = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0B102F),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Color(0xFF0B102F),
      body: Obx(() {
        if (moviesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (moviesController.movies.isEmpty) {
          return Center(
            child: Text(
              "لا توجد أفلام حالياً",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
        }

        return SingleChildScrollView(
          // ✅ جعل الصفحة قابلة للتمرير عموديًا
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Wrap(
              spacing: 45, // المسافة بين العناصر أفقيًا
              runSpacing: 10, // المسافة بين الصفوف
              alignment: WrapAlignment.center,
              children: moviesController.movies.map((movie) {
                return GestureDetector(
                  onTap: () {
                    // ⬇ تابع الضغط على الصورة هنا
                    Get.to(DetailsView(), arguments: {'movieId': movie.id});
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                          height: 200, // ✅ زيادة الطول
                          width: 130, // ✅ زيادة العرض
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 130, // ✅ لضمان عدم تمدد النص أكثر من الصورة
                        child: Text(
                          movie.title,
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
