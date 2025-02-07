import 'package:filmclick/models/football/team_model.dart';

class StandingsModel {
  final int position;
  final TeamModel team;
  final int points;
  final int playedGames;

  StandingsModel({
    required this.position,
    required this.team,
    required this.points,
    required this.playedGames,
  });

  factory StandingsModel.fromJson(Map<String, dynamic> json) {
    return StandingsModel(
      position: json['position'],
      team: TeamModel.fromJson(json['team']),
      points: json['points'],
      playedGames: json['playedGames'],
    );
  }
}
