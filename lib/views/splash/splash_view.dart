import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed(AppRoutes.landing);
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF36FFDB), Color(0xFF1A2E46)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/animation/Logo-23.json',
            width: 244,
            height: 244,
            fit: BoxFit.cover,
          ),
          
        ),
        
      ),
      
    );
  }
}
