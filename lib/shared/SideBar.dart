import 'package:filmclick/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SideBar extends StatelessWidget {
  final String currentRoute;

  const SideBar({Key? key, required this.currentRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(top: 50, right: 10),
        width: 80,
        height: 670,
        decoration: BoxDecoration(
          color: Color(0xFF1A2E46).withOpacity(0.75), // إضافة الشفافية للخلفية
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            // استخدام Lottie بدلاً من الصورة الثابتة
            Padding(
              padding: const EdgeInsets.all(9),
              child: Container(
                  width: 57,
                  height: 57,
                  child: Image.asset("assets/images/cin.png")),
            ),

            SizedBox(height: 170),
            // بقية الأزرار
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconButton(Icons.home, AppRoutes.home, currentRoute),
                  SizedBox(height: 15),
                  _buildIconButton(Icons.movie, AppRoutes.movies, currentRoute),
                  SizedBox(height: 15),
                  _buildIconButton(Icons.tv, AppRoutes.series, currentRoute),
                  SizedBox(height: 15),
                  _buildIconButton(
                      Icons.favorite, AppRoutes.favorites, currentRoute),
                  SizedBox(height: 15),
                  _buildIconButton(
                      Icons.settings, AppRoutes.settings, currentRoute),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String route, String currentRoute) {
    final isSelected = route == currentRoute;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Get.toNamed(route);
        }
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            height: isSelected ? 50 : 40,
            width: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? Color(0xFF36FFDB).withOpacity(0.5)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Color(0xFF36FFDB),
              size: isSelected ? 32 : 28,
            ),
          ),
          if (isSelected) ...[
            SizedBox(height: 4),
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 300),
              child: Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(0xFF36FFDB),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SideBarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78,
      height: 670,
      child: SideBar(currentRoute: AppRoutes.home),
    );
  }
}
