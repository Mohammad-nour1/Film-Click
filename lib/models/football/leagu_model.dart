class LeagueModel {
  final String? strLeague;
  final String? strBadge;
  final String? strCountry;

  LeagueModel({
    this.strLeague,
    this.strBadge,
    this.strCountry,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      strLeague: json['strLeague'],
      strBadge: json['strBadge'],
      strCountry: json['strCountry'],
    );
  }
}
