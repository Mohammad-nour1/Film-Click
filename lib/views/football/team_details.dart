import 'package:filmclick/models/football/team_details_model.dart';
import 'package:filmclick/services/football_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TeamDetailsPage extends StatefulWidget {
  @override
  _TeamDetailsPageState createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  final FootballService _footballService = FootballService();
  late Future<TeamDetails> _teamDetailsFuture;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>?;
    final teamId = arguments?['teamId'];
    _teamDetailsFuture =
        _footballService.fetchTeamDetails(teamId); // تحميل البيانات عند الدخول
  }

  void _refreshData() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    final teamId = arguments?['teamId'];
    setState(() {
      _teamDetailsFuture = _footballService.fetchTeamDetails(
          teamId); // إعادة تحميل البيانات عند الضغط على زر التحديث
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    final crestUrl = arguments?['crestUrl']; // الحصول على رابط الصورة

    return WillPopScope(
      onWillPop: () async {
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
              Get.back();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed:
                  _refreshData, // عند الضغط على زر التحديث، سيتم تحديث البيانات
            ),
          ],
        ),
        body: FutureBuilder<TeamDetails>(
          future: _teamDetailsFuture, // استخدام المستقبل الذي يحمل البيانات
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
