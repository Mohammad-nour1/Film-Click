import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/controllers/searchh_controller.dart'; // تأكد من أنك تستخدم SearchhController

class SearchView extends StatelessWidget {
  final SearchhController searchController =
      Get.put(SearchhController()); // استيراد SearchhController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 11, 16, 47), // نفس اللون مثل HomeView
      appBar: AppBar(
        title: Text("search...",
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic,)), // تغيير لون النص إلى الأبيض
        backgroundColor:
            const Color.fromARGB(255, 11, 16, 47), // نفس اللون مثل HomeView
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // تغيير لون زر الرجوع إلى الأبيض
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // مربع البحث
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                searchController.searchText.value = query;
                searchController.search(query);
              },
              decoration: InputDecoration(
                hintText: "ابحث عن أفلام أو مسلسلات...",
                filled: true,
                fillColor: Color(0xFF36FFDB), // تغيير لون مربع البحث
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
      
          Expanded(
            child: Obx(() {
              if (searchController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 6, // تحديد عرض الحافة
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF36FFDB)), // لون دائرة التحميل
                  ),
                );
              }

              // عرض الجملة "سامحنا، لم نجد ما بحثت عنه" عند عدم وجود نتائج
              if (searchController.movies.isEmpty &&
                  searchController.tvShows.isEmpty &&
                  searchController.searchText.value.isNotEmpty) {
                return Center(
                  child: Text(
                    "سامحنا، لم نجد ما بحثت عنه", // الرسالة إذا لم توجد نتائج
                    style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic,),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              // عرض الأفلام والمسلسلات إذا كانت موجودة
              return ListView(
                children: [
                  if (searchController.movies.isNotEmpty) ...[
                    Text("🎬 أفلام",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    ...searchController.movies.map((movie) => ListTile(
                          leading: Image.network(
                              "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                              width: 50),
                          title: Text(movie.title,
                              style: TextStyle(color: Colors.white)),
                        )),
                  ],
                  if (searchController.tvShows.isNotEmpty) ...[
                    Text("📺 مسلسلات",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    ...searchController.tvShows.map((tv) => ListTile(
                          leading: Image.network(
                              "https://image.tmdb.org/t/p/w200${tv.posterPath}",
                              width: 50),
                          title: Text(tv.name,
                              style: TextStyle(color: Colors.white)),
                        )),
                  ],
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
