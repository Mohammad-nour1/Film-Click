class EventModel {
  final String homeTeam;
  final String awayTeam;
  final String date;
  final String time;

  EventModel({
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    required this.time,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      homeTeam: json['homeTeam']['name'] ?? 'Unknown Team',
      awayTeam: json['awayTeam']['name'] ?? 'Unknown Team',
      date: json['utcDate']?.split('T')[0] ?? 'No Date', // تقسيم التاريخ من UTC
      time: json['utcDate']?.split('T')[1].split('Z')[0] ?? 'No Time', // تقسيم الوقت
    );
  }
}
