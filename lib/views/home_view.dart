import 'package:filmclick/shared/SideBar.dart';
import 'package:filmclick/views/search_veiw.dart';
import 'package:filmclick/views/home/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart'; // لإظهار التوست
import 'package:flutter/services.dart'; // للخروج من التطبيق
import 'package:filmclick/controllers/home_controller.dart';
import 'package:filmclick/controllers/settings_controller.dart';
import 'package:filmclick/views/home/main_body.dart';
import 'package:filmclick/views/home/header_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final SettingsController settingsController = Get.put(SettingsController());

  DateTime? lastPressedTime; // متغير لحفظ وقت آخر ضغطة على زر الرجوع

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // إذا كان السايد بار مفتوحًا، قم بإغلاقه بدلًا من الخروج
        if (settingsController.isSideBarOpen.value) {
          settingsController.toggleSettings();
          return false;
        }

        DateTime now = DateTime.now();
        if (lastPressedTime == null ||
            now.difference(lastPressedTime!) > const Duration(seconds: 2)) {
          lastPressedTime = now;
          Fluttertoast.showToast(
            msg: "اضغط مرة أخرى للخروج",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return false; // لا يخرج من التطبيق عند الضغط لأول مرة
        }

        // إذا ضغط المستخدم مرتين خلال ثانيتين، يخرج التطبيق
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(color: const Color.fromARGB(255, 11, 16, 47)),
            Obx(() {
              if (homeController.isLoading.value) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      buildShimmerCarousel(),
                      const SizedBox(height: 20),
                      buildShimmerHorizontalList('أفلام شائعة'),
                      const SizedBox(height: 20),
                      buildShimmerHorizontalList('مسلسلات شائعة'),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await homeController.refreshData();
                },
                child: SingleChildScrollView(
                  child: MainBody(
                    upcomingMoviesFuture:
                        Future.value(homeController.upcomingMovies),
                    popularMoviesFuture: Future.value(homeController.movies),
                    popularTvShowsFuture: Future.value(homeController.tvShows),
                  ),
                ),
              );
            }),
            Positioned(
              top: 60,
              left: 55,
              right: 95,
              child: GestureDetector(
                onTap: () => Get.to(() => SearchView()),
                child: AbsorbPointer(child: HeaderWidget()),
              ),
            ),
            Positioned(
              top: 60,
              left: 0,
              child: Obx(() {
                return IconButton(
                  icon: Icon(
                    settingsController.isSideBarOpen.value
                        ? Icons.close
                        : Icons.menu,
                    color: const Color.fromARGB(255, 103, 237, 250),
                    size: 30,
                  ),
                  onPressed: () {
                    settingsController.toggleSettings();
                  },
                );
              }),
            ),
            Obx(() => AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  left: settingsController.isSideBarOpen.value
                      ? 0
                      : -MediaQuery.of(context).size.width * 0.5,
                  top: 0,
                  bottom: 0,
                  child: SettingsView(),
                )),
          ],
        ),
      ),
    );
  }
}

/// **إنشاء شريط أفلام (Skeleton Loading)**
Widget buildShimmerCarousel() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          'أفلام مميزة',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'CooperArabic',
          ),
        ),
      ),
      const SizedBox(height: 15),
      SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(145, 38, 240, 217),
                  highlightColor: const Color.fromARGB(255, 4, 33, 36),
                  child: Container(
                    width: 180,
                    height: 250,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(145, 38, 240, 217),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

/// **إنشاء قائمة أفلام أفقية بتصميم أفضل**
Widget buildShimmerHorizontalList(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'CooperArabic',
          ),
        ),
      ),
      const SizedBox(height: 15),
      SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(145, 38, 240, 217),
                  highlightColor: const Color.fromARGB(255, 4, 40, 47),
                  child: Container(
                    width: 140,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(145, 38, 240, 217),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
