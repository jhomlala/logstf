import 'package:logstf/model/external/class_kill.dart';
import 'package:logstf/model/external/info.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/model/external/round.dart';
import 'package:logstf/model/external/teams.dart';

import '../internal/log_short.dart';

class Log {
  final Teams teams;
  final Map<String, Player> players;
  final List<Round> rounds;
  final Info info;
  final int length;
  final Map<String, String> names;
  final Map<String, ClassKill> classKills;
  final Map<String, ClassKill> classDeaths;
  final Map<String, ClassKill> classKillAssists;
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
      this.classDeaths,
      this.classKillAssists,
      this.healspread,
      this.id});

  factory Log.fromJson(Map<String, dynamic> json, int id) => Log(
      teams: Teams.fromJson(json["teams"]),
      players: Map.from(json["players"])
          .map((k, v) => MapEntry<String, Player>(k, Player.fromJson(v, k))),
      rounds: (json["rounds"] as List).map((i) => Round.fromJson(i)).toList(),
      info: Info.fromJson(json["info"]),
      length: json["length"],
      names:
          Map.from(json["names"]).map((k, v) => MapEntry<String, String>(k, v)),
      classKills: Map.from(json["classkills"])
          .map((k, v) => MapEntry<String, ClassKill>(k, ClassKill.fromJson(v))),
      classDeaths: Map.from(json["classdeaths"])
          .map((k, v) => MapEntry<String, ClassKill>(k, ClassKill.fromJson(v))),
      classKillAssists: Map.from(json["classkillassists"])
          .map((k, v) => MapEntry<String, ClassKill>(k, ClassKill.fromJson(v))),
      healspread: Map.from(json["healspread"]).map((k, v) =>
          MapEntry<String, Map<String, int>>(
              k, Map.from(v).map((k, v) => MapEntry<String, int>(k, v)))),
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
        players: players.length,
        views: 0);
  }
}
