import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Landing.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // All elements inside one container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Watch Your Movies\nanytime anywhere',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Explore a vast collection of blockbuster movies, timeless classics, and the latest releases.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Button inside the same container
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF36FFDB),
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width *
                                0.36, // استخدم النسبة لتحديد العرض بناءً على حجم الشاشة
                            vertical: 9,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors
                                  .black), // تقليل حجم النص ليظهر بشكل مناسب على الشاشات الصغيرة والكبيرة
                        ),
                      ),

                      OutlinedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.register);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Color(0xFF36FFDB),
                              width: 2), // إطار بلون النص
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width *
                                0.18, // استخدم النسبة لتحديد العرض بناءً على حجم الشاشة
                            vertical: 9,
                          ), // تغيير الحجم
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // زوايا دائرية
                          ),
                        ),
                        child: const Text(
                          'New Member ? Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF36FFDB), // لون النص نفس لون الإطار
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
