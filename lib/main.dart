import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';
import 'package:filmclick/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Film Click',
      theme: ThemeData(
        primaryColor: const Color(0xFF36FFDB),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF1A2E46)),
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
