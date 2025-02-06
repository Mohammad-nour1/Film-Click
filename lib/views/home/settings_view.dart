import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:filmclick/controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        color: Color.fromARGB(207, 11, 16, 47), // لون الخلفية
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            // زر الرجوع
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                controller.toggleSettings(); // غلق القائمة عند الضغط
              },
            ),
            SizedBox(height: 10),

            // صورة الملف الشخصي
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(
                  "assets/images/prof.png"), // استبدلها بالصورة الفعلية
            ),
            SizedBox(height: 10),

            // البريد الإلكتروني
            Text(
              "example@gmail.com",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),

            // زر تسجيل الخروج
            ElevatedButton.icon(
              onPressed: () => print("تسجيل الخروج"),
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text(
                "تسجيل الخروج",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(126, 54, 255, 218),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadowColor: const Color.fromARGB(255, 5, 237, 245),
                elevation: 9,
              ),
            ),

            SizedBox(
              height: 24,
            ),
            ElevatedButton.icon(
              onPressed: _openTelegram,
              icon: Icon(Icons.telegram, color: Colors.white),
              label: Text(
                "تواصل مع المطور",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(126, 54, 255, 218),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadowColor: const Color.fromARGB(255, 5, 237, 245),
                elevation: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openTelegram() async {
    final Uri telegramUrl = Uri.parse("https://t.me/mohammadnourawad");

    if (await canLaunchUrl(telegramUrl)) {
      await launchUrl(telegramUrl, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("خطأ", "تعذر فتح تيليغرام");
    }
  }
}
