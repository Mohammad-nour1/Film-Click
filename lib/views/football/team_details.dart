import 'package:filmclick/models/football/team_details_model.dart';
import 'package:filmclick/services/football_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TeamDetailsPage extends StatelessWidget {
  final FootballService _footballService = FootballService();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    final teamId = arguments?['teamId']; // الحصول على الفريق من arguments
    final crestUrl = arguments?['crestUrl']; // الحصول على رابط الصورة

    return WillPopScope(
      onWillPop: () async {
        // عند العودة، نقوم بتحديث البيانات (إن أردت).
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 11, 16, 47),
        appBar: AppBar(
          title: Text('Team Details', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 11, 16, 47),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // استخدام Get.back() للرجوع إلى الصفحة السابقة
              Get.back();
            },
          ),
        ),
        body: FutureBuilder<TeamDetails>(
          future: _footballService
              .fetchTeamDetails(teamId), // تحميل البيانات عند الدخول
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final teamDetails = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.network(crestUrl ?? ''), // استخدام الصورة هنا
                    SizedBox(height: 20),
                    Text(
                      teamDetails.name,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Founded: ${teamDetails.founded}',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Stadium: ${teamDetails.venue}',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Address: ${teamDetails.venue}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  "قريباً سوف تتوفر معلومات الفريق يا صاحبي",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
