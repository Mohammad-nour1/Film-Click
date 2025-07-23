// main.dart
import 'package:filmclick/controllers/searchh_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => SearchhController());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    
  
  ));
  
  runApp(MyApp());
}
