import 'package:logstf/model/external/event.dart';
import 'package:logstf/model/external/round_player.dart';
import 'package:logstf/model/external/teams.dart';

class Round {
  final int startTime;
  final String winner;
  final Teams team;
  final List<Event> events;
  final Map<String, RoundPlayer> players;

  Round({this.startTime, this.winner, this.team, this.events, this.players});

  factory Round.fromJson(Map<String, dynamic> json) => Round(
      startTime: json["start_time"],
      winner: json["winner"],
      team: Teams.fromJson(json["team"]),
      events:
          (json["events"] as List).map((i) => new Event.fromJson(i)).toList(),
      players: new Map.from(json["players"])
          .map((k, v) => new MapEntry<String, RoundPlayer>(k, RoundPlayer.fromJson(v))));

  @override
  String toString() {
    return 'Round{startTime: $startTime, winner: $winner, team: $team, events: $events, players: $players}';
  }


}
