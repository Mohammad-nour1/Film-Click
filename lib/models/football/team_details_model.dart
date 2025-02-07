class TeamDetails {
  final int id;
  final String name;
  final String shortName;
  final String? crestUrl;
  final String? coach;
  final String? founded;
  final String? venue;

  TeamDetails({
    required this.id,
    required this.name,
    required this.shortName,
    this.crestUrl,
    this.coach,
    this.founded,
    this.venue,
  });

  // تحويل البيانات من JSON إلى كائن TeamDetails
  factory TeamDetails.fromJson(Map<String, dynamic> json) {
    return TeamDetails(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      crestUrl: json['crestUrl'],
      coach: json['coach'] != null ? json['coach']['name'] : null,
      founded: json['founded'].toString(),
      venue: json['venue'],
    );
  }

  // تحويل كائن TeamDetails إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'crestUrl': crestUrl,
      'coach': coach,
      'founded': founded,
      'venue': venue,
    };
  }
}
