import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الصورة الخلفية
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rigspic.png'),
                fit: BoxFit.fill, // ملء الشاشة بالكامل
              ),
            ),
          ),
          // تأثير التلاشي في الأسفل
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 400, // ارتفاع التلاشي
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
          // محتوى الصفحة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 246, 246),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'User Name',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.black54),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF36FFDB),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 132, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 21, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Login',
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
