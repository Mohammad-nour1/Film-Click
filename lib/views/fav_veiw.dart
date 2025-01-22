import 'package:filmclick/views/details_veiw.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/controllers/details_controller.dart';
// تأكد من استيراد صفحة التفاصيل

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailsController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white, // جعل النص في AppBar أبيض
          ),
        ),
        backgroundColor: Color.fromARGB(255, 11, 16, 47),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // تغيير لون زر الرجوع إلى الأبيض
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return Center(
            child: Text(
              'No favorites added yet.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final item = controller.favorites[index];
            return Column(
              children: [
                ListTile(
                  leading: Image.network(
                    "https://image.tmdb.org/t/p/w200${item['posterPath']}",
                    width: 80,
                  ),
                  title: Text(
                    item['title'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // تحديد ما إذا كان العنصر فيلمًا أو مسلسلًا
                    if (item['type'] == 'movie') {
                      controller.setMovieFromFavorites(item);
                    } else if (item['type'] == 'tv') {
                      controller.setTvShowFromFavorites(item);
                    }
                    // الانتقال إلى صفحة التفاصيل
                    Get.to(() => DetailsView());
                  },
                ),
                Divider(
                  color: const Color.fromARGB(
                      161, 21, 236, 247), // تغيير لون الخط هنا
                  thickness: 2.5, // تغيير سمك الخط هنا
                  indent: 18, // المسافة من الجهة اليسرى
                  endIndent: 18, // المسافة من الجهة اليمنى
                ),
              ],
            );
          },
        );
      }),
      backgroundColor: Color.fromARGB(255, 11, 16, 47),
    );
  }
}
