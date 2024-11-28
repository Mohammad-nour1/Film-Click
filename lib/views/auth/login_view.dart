import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/routes/app_routes.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF36FFDB), Color(0xFF1A2E46)], 
            begin: Alignment.topLeft,
            transform: GradientRotation(3),
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, 
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: const OutlineInputBorder(),
                    filled: true, 
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: const OutlineInputBorder(),
                    filled: true, 
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                  
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A2E46), 
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  child: const Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(
                      color: Colors.white, 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
