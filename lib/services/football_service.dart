import 'dart:convert';
import 'package:filmclick/models/football/Event_model.dart';
import 'package:filmclick/models/football/leagu_model.dart';
import 'package:filmclick/models/football/team_model.dart';
import 'package:http/http.dart' as http;

class FootballService {
  final String baseUrl = 'https://www.thesportsdb.com/api/v1/json/3/';

  // الحصول على المباريات القادمة
  Future<List<EventModel>> fetchUpcomingMatches() async {
    final response =
        await http.get(Uri.parse('$baseUrl/eventsnextleague.php?id=4328'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['events'] != null) {
        return List<EventModel>.from(
          data['events'].map((match) => EventModel.fromJson(match)),
        );
      } else {
        throw Exception('No upcoming matches found');
      }
    } else {
      throw Exception('Failed to load upcoming matches');
    }
  }

  // الحصول على الفرق الرياضية في إسبانيا
  Future<List<TeamModel>> fetchTeamsInSpain() async {
    final response = await http.get(
      Uri.parse('$baseUrl/search_all_teams.php?l=English%20Premier%20League'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['teams'] != null) {
        return List<TeamModel>.from(
          data['teams'].map((team) => TeamModel.fromJson(team)),
        );
      } else {
        throw Exception('No teams found');
      }
    } else {
      throw Exception('Failed to load teams');
    }
  }

  // الحصول على جميع البطولات
  Future<List<LeagueModel>> fetchAllLeagues() async {
    final response = await http.get(
      Uri.parse('$baseUrl/all_leagues.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['leagues'] != null) {
        return List<LeagueModel>.from(
          data['leagues'].map((league) => LeagueModel.fromJson(league)),
        );
      } else {
        throw Exception('No leagues found');
      }
    } else {
      throw Exception('Failed to load leagues');
    }
  }
}
