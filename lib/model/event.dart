class Event {
  final String type;
  final int time;
  final String team;
  final String steamId;
  final String killer;

  Event({this.type, this.time, this.team, this.steamId, this.killer});

  factory Event.fromJson(Map<String, dynamic> json) => Event(
      type: json["type"],
      time: json["time"],
      team: json["team"],
      steamId: json["steamId"],
      killer: json["killer"]);
}
