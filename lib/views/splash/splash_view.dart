import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () {
      Get.offNamed(AppRoutes.login);
    });

    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animation/Logo-22.json',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
