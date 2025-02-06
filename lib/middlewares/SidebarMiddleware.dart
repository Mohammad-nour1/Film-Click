import 'package:filmclick/shared/SideBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SidebarMiddleware extends GetMiddleware {
  final List<String> excludedRoutes = [
    "/splash",
    "/login",
    "/loading",
    "/register"
  ];

  @override
  RouteSettings? redirect(String? route) {
    if (excludedRoutes.contains(route)) {
      return null; // لا تفعل شيئًا، تابع التنقل الطبيعي
    }
    return null; // السماح بالانتقال، لكن سيتم لف الصفحة لاحقًا بـ Sidebar
  }

  @override
  Widget onPageBuilt(Widget page) {
    if (excludedRoutes.contains(Get.currentRoute)) {
      return page; // لا نلفها بالشريط الجانبي
    }

    return Scaffold(
      body: Stack(
        children: [
          page, // الصفحة الحالية
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: SideBar(), // إضافة الشريط الجانبي بشكل تلقائي للصفحات المناسبة
          ),
        ],
      ),
    );
  }
}
