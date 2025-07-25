// main.dart
import 'package:filmclick/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';
import 'package:filmclick/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotificationService notificationService = NotificationService();
    notificationService.initializeNotifications();
    notificationService.requestNotificationPermissions(); // Request permissions
    notificationService.startPeriodicNotifications(); // Start periodic notifications
    
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
