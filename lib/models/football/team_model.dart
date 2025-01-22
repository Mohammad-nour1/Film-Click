class TeamModel {
  final String? strTeam;
  final String? strBadge;

  TeamModel({
    this.strTeam,
    this.strBadge,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      strTeam: json['strTeam'],
      strBadge: json['strBadge'],
    );
  }
}
