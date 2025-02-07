class TeamModel {
  final int id;
  final String name;
  final String logo;

  TeamModel({required this.id, required this.name, required this.logo});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'],
      logo: json['crest'], // قد يكون `logo` أو `crest` حسب API
    );
  }
}
