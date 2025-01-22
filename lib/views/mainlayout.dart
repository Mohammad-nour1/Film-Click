import 'package:filmclick/shared/SideBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';


class MainLayout extends StatelessWidget {
  final Widget content;

  MainLayout({required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          content, // الصفحة الرئيسية التي سيتم عرضها
          SideBar(currentRoute: Get.currentRoute), // الشريط الجانبي
        ],
      ),
    );
  }
}
