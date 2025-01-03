import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية الصورة
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logpic.png'), // مسار الصورة
                fit: BoxFit.cover, // لتعبئة الشاشة بالكامل
              ),
            ),
          ),
          // تأثير التلاشي في الأسفل
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(0, 61, 218, 239), // يبدأ شفافًا
                    const Color.fromARGB(255, 53, 227, 236)
                        .withOpacity(0.7), // تدريج إلى اللون الأسود
                  ],
                ),
              ),
            ),
          ),
          // محتوى الواجهة
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // وضع المحتوى في الأسفل
              crossAxisAlignment: CrossAxisAlignment.center, // توسيط المحتوى
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7), // خلفية شفافة
                    borderRadius: BorderRadius.circular(16.0), // حواف دائرية
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 246, 246),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black54),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility,
                                color: Colors.black54),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.home);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF36FFDB),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 145, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 21, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.register);
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Haven\'t made an account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF36FFDB),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
