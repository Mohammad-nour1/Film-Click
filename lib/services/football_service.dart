import 'package:filmclick/models/football/standing_model.dart';
import 'package:filmclick/models/football/team_details_model.dart';
import 'package:filmclick/models/football/team_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FootballService {
  final String baseUrl = "https://api.football-data.org/v4";
  final String apiKey = "29d3df87dfcb4e4ba26dfe1307d96c7b"; // ضع مفتاح API هنا

  Future<List<dynamic>> fetchLeagueTable(String leagueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/competitions/$leagueId/standings'),
      headers: {'X-Auth-Token': apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['standings'][0]['table'];
    } else {
      throw Exception('Failed to load league standings');
    }
  }

  Future<TeamDetails> fetchTeamDetails(int teamId) async {
  final response = await http.get(
    Uri.parse('https://api.football-data.org/v4/teams/$teamId'),
    headers: {'X-Auth-Token': '29d3df87dfcb4e4ba26dfe1307d96c7b'},
  );

  if (response.statusCode == 200) {
    return TeamDetails.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load team details');
  }
}


  Future<List<TeamModel>> fetchTeams(String leagueCode) async {
    final response = await http.get(
      Uri.parse(
          'https://api.football-data.org/v4/competitions/$leagueCode/teams'),
      headers: {'X-Auth-Token': '29d3df87dfcb4e4ba26dfe1307d96c7b'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List teams = data['teams'];
      return teams.map((json) => TeamModel.fromJson(json)).toList();
    } else {
      throw Exception('29d3df87dfcb4e4ba26dfe1307d96c7b');
    }
  }

  Future<List<StandingsModel>> fetchStandings(String leagueCode) async {
    final response = await http.get(
      Uri.parse(
          'https://api.football-data.org/v4/competitions/$leagueCode/standings'),
      headers: {'X-Auth-Token': '29d3df87dfcb4e4ba26dfe1307d96c7b'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List standings = data['standings'][0]['table'];
      return standings.map((json) => StandingsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load standings');
    }
  }
}
