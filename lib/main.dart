import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // يجعل شريط الحالة شفاف
    statusBarIconBrightness: Brightness
        .light, // يجعل أيقونات شريط الحالة فاتحة اللون (للاستخدام مع الخلفيات الداكنة)
  ));
  runApp(MyApp());
}

