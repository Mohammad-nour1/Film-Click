// main.dart
import 'package:filmclick/controllers/searchh_controller.dart';
import 'package:filmclick/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'app.dart'; // استدعاء MyApp من ملف مستقل

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => SearchhController());
  await FlutterDownloader.initialize(debug: true);

  NotificationService notificationService = NotificationService();
  await notificationService.initializeNotifications();
  
  // طلب الأذونات (في حال كانت هناك مشكلة في الأذونات)
  await notificationService.requestNotificationPermissions();
  
  // اختبار الإشعار بشكل يدوي
  notificationService.showNotification(); // عرض إشعار يدوي للتأكد من عمله
  
  notificationService.startPeriodicNotifications(); // إرسال إشعارات متكررة
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(MyApp());
}
