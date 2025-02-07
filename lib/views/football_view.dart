import 'package:filmclick/models/football/standing_model.dart';
import 'package:filmclick/models/football/team_model.dart';
import 'package:filmclick/services/football_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FootballView extends StatefulWidget {
  @override
  _FootballViewState createState() => _FootballViewState();
}

class _FootballViewState extends State<FootballView> {
  int _selectedIndex = 0;
  final String videoUrl = "https://youtu.be/ghz-w_Amuyc";
  late YoutubePlayerController _controller;
  final FootballService _footballService = FootballService();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 16, 47),
      appBar: AppBar(
        title: Text("Football View", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 11, 16, 47),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.toNamed("/home");
          },
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildStandings(),
          _buildTeamsList(),
          _buildStreamingView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 11, 16, 47),
        selectedItemColor: const Color.fromARGB(255, 89, 239, 209),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'Standings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Streaming',
          ),
        ],
      ),
    );
  }

  Widget _buildStandings() {
    return RefreshIndicator(
      onRefresh: _refreshStandings,
      child: FutureBuilder<List<StandingsModel>>(
        future: _footballService.fetchStandings(
            "PD"), // تأكد من استخدام الرمز الصحيح للدوري الإسباني
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final standings = snapshot.data!;
            return ListView.builder(
              itemCount: standings.length,
              itemBuilder: (context, index) {
                final standing = standings[index];
                return Card(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      '${standing.position}. ${standing.team.name}',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Points: ${standing.points} | Played: ${standing.playedGames}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    leading: Image.network(standing.team.logo, width: 40),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No standings available'));
          }
        },
      ),
    );
  }

  Widget _buildTeamsList() {
    return RefreshIndicator(
      onRefresh: _refreshTeams,
      child: FutureBuilder<List<TeamModel>>(
        future: _footballService.fetchTeams("PD"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final teams = snapshot.data!;
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return ListTile(
                  title: Text(
                    team.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Image.network(team.logo),
                  onTap: () {
                    Get.toNamed("/teamDetails", arguments: {
                      "teamId": team.id,
                      "crestUrl": team.logo,
                    });
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No teams available'));
          }
        },
      ),
    );
  }

  Widget _buildStreamingView() {
    return RefreshIndicator(
      onRefresh: _refreshStreaming,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    player,
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // دالة لتحديث بيانات standings
  Future<void> _refreshStandings() async {
    setState(() {
      // يمكنك تحديث البيانات هنا، مثل استدعاء الدالة التي جلبت البيانات
    });
  }

  // دالة لتحديث بيانات الفرق
  Future<void> _refreshTeams() async {
    setState(() {
    });
  }

  Future<void> _refreshStreaming() async {
    setState(() {
    });
  }
}
