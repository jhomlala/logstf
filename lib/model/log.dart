import 'package:logstf/model/info.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/round.dart';
import 'package:logstf/model/teams.dart';

class Log {
  final Teams teams;
  final Map<String, Player> players;
  final List<Round> rounds;
  final Info info;
  final int length;
  final Map<String, String> names;

  Log(
      {this.teams,
      this.players,
      this.rounds,
      this.info,
      this.length,
      this.names});

  factory Log.fromJson(Map<String, dynamic> json) => Log(
      teams: Teams.fromJson(json["teams"]),
      players: new Map.from(json["players"])
          .map((k, v) => new MapEntry<String, Player>(k, Player.fromJson(v,k))),
      rounds:
          (json["rounds"] as List).map((i) => new Round.fromJson(i)).toList(),
      info: Info.fromJson(json["info"]),
      length: json["length"],
      names:new Map.from(json["names"])
          .map((k, v) => new MapEntry<String, String>(k, v)),);
}
