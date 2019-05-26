import 'package:logstf/model/class_kill.dart';
import 'package:logstf/model/info.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/round.dart';
import 'package:logstf/model/teams.dart';

import 'log_short.dart';

class Log {
  final Teams teams;
  final Map<String, Player> players;
  final List<Round> rounds;
  final Info info;
  final int length;
  final Map<String, String> names;
  final Map<String, ClassKill> classKills;
  final Map<String, Map<String, int>> healspread;
  int id;

  Log(
      {this.teams,
      this.players,
      this.rounds,
      this.info,
      this.length,
      this.names,
      this.classKills,
      this.healspread,
      this.id});

  factory Log.fromJson(Map<String, dynamic> json, int id) => Log(
      teams: Teams.fromJson(json["teams"]),
      players: new Map.from(json["players"]).map(
          (k, v) => new MapEntry<String, Player>(k, Player.fromJson(v, k))),
      rounds:
          (json["rounds"] as List).map((i) => new Round.fromJson(i)).toList(),
      info: Info.fromJson(json["info"]),
      length: json["length"],
      names: new Map.from(json["names"])
          .map((k, v) => new MapEntry<String, String>(k, v)),
      classKills: new Map.from(json["classkills"]).map(
          (k, v) => new MapEntry<String, ClassKill>(k, ClassKill.fromJson(v))),
      healspread: new Map.from(json["healspread"]).map((k, v) =>
          new MapEntry<String, Map<String, int>>(k,
              new Map.from(v).map((k, v) => new MapEntry<String, int>(k, v)))),
      id: id);

  String getPlayerName(String steamId) {
    if (names.containsKey(steamId)) {
      return names[steamId];
    } else {
      return "???";
    }
  }

  LogShort setupShortLog() {
    return LogShort(
        id: id,
        title: info.title,
        map: info.map,
        date: info.date,
        players: players.length);
  }
}
