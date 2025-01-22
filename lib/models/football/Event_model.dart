class EventModel {
  final String? strEvent;
  final String? dateEvent;
  final String? strTime;
  final String? strVenue;
  final String? strHomeTeamBadge;
  final String? strAwayTeamBadge;

  EventModel({
    this.strEvent,
    this.dateEvent,
    this.strTime,
    this.strVenue,
    this.strHomeTeamBadge,
    this.strAwayTeamBadge,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      strEvent: json['strEvent'],
      dateEvent: json['dateEvent'],
      strTime: json['strTime'],
      strVenue: json['strVenue'],
      strHomeTeamBadge: json['strHomeTeamBadge'],
      strAwayTeamBadge: json['strAwayTeamBadge'],
    );
  }
}
