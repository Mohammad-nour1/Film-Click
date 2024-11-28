import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A2E46), Color(0xFF36FFDB)], 
            begin: Alignment.topCenter,
            transform: GradientRotation(1),
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
                  'Register',
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
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Already have an account? Login',
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
