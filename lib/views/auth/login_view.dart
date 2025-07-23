import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية الصورة
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logpic.png'),
                fit: BoxFit.cover,
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
                    const Color.fromARGB(0, 61, 218, 239),
                    const Color.fromARGB(255, 53, 227, 236).withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          // محتوى الواجهة
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 246, 246),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: emailController, // تحكم بحقل البريد
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
                        controller: passwordController, // تحكم بحقل الباسورد
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
                          if (emailController.text == 'admin' &&
                              passwordController.text == 'admin') {
                            Get.toNamed(AppRoutes.home);
                          } else {
                            Get.snackbar(
                              'Error',
                              'Invalid email or password',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.withOpacity(0.8),
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF36FFDB),
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.32,
                            vertical: 9,
                          ),
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
