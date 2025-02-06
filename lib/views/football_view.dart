import 'package:flutter/material.dart';
import 'package:filmclick/models/football/Event_model.dart';
import 'package:filmclick/models/football/leagu_model.dart';
import 'package:filmclick/models/football/team_model.dart';
import 'package:filmclick/services/football_service.dart';

class FootballView extends StatefulWidget {
  @override
  _FootballViewState createState() => _FootballViewState();
}

class _FootballViewState extends State<FootballView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            Navigator.pop(context);
          },
        ),
      ),
      body: _selectedIndex == 0
          ? FutureBuilder<List<EventModel>>(
              future: FootballService().fetchUpcomingMatches(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final matches = snapshot.data!;
                  return ListView.builder(
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      final match = matches[index];
                      return Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            match.strEvent ?? 'Unknown Match',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${match.dateEvent} at ${match.strTime}',
                            style: TextStyle(color: Colors.white),
                          ),
                          leading: Image.network(match.strHomeTeamBadge ?? ''),
                          trailing: Image.network(match.strAwayTeamBadge ?? ''),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No matches available'));
                }
              },
            )
          : _selectedIndex == 1
              ? FutureBuilder<List<LeagueModel>>(
                  future: FootballService().fetchAllLeagues(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final leagues = snapshot.data!;
                      return ListView.builder(
                        itemCount: leagues.length,
                        itemBuilder: (context, index) {
                          final league = leagues[index];
                          return Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              title: Text(
                                league.strLeague ?? 'Unknown League',
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Image.network(league.strBadge ?? ''),
                              subtitle: Text(
                                'Country: ${league.strCountry ?? 'Unknown'}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No leagues available'));
                    }
                  },
                )
              : FutureBuilder<List<TeamModel>>(
                  future: FootballService().fetchTeamsInSpain(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final teams = snapshot.data!;
                      return ListView.builder(
                        itemCount: teams.length,
                        itemBuilder: (context, index) {
                          final team = teams[index];
                          return Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              title: Text(
                                team.strTeam ?? 'Unknown Team',
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Image.network(team.strBadge ?? ''),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No teams available'));
                    }
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 11, 16, 47),
        selectedItemColor: const Color.fromARGB(255, 89, 239, 209),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Upcoming Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leagues',
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
}
