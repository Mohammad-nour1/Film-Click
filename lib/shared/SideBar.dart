import 'package:filmclick/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key); // 🔹 إزالة currentRoute من هنا

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(top: 50, right: 10),
        width: 80,
        height: 590,
        decoration: BoxDecoration(
          color: Color(0xFF1A2E46).withOpacity(0.75),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9),
              child: Container(
                width: 57,
                height: 57,
                child: Image.asset("assets/images/cin.png"),
              ),
            ),
            SizedBox(height: 150),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconButton(Icons.home, AppRoutes.home),
                  SizedBox(height: 15),
                  _buildIconButton(Icons.movie, AppRoutes.movies),
                  SizedBox(height: 15),
                  _buildIconButton(Icons.tv, AppRoutes.tvshows),
                  SizedBox(height: 15),
                  _buildIconButton(Icons.favorite, AppRoutes.favorites),
                  SizedBox(height: 15),
                  _buildIconButton(Icons.sports_soccer, AppRoutes.football),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String route) {
    final isSelected =
        route == Get.currentRoute; // ✅ استخدام Get.currentRoute مباشرة

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Get.offNamed(route);
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
