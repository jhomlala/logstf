import 'package:logstf/model/weapon.dart';

class ClassStats{
  final String type;
  final int kills;
  final int assists;
  final int deaths;
  final int dmg;
  final Map<String,Weapon> weapon;
  final int totalTime;

  ClassStats({this.type, this.kills, this.assists, this.deaths, this.dmg, this.weapon, this.totalTime});

  factory ClassStats.fromJson(Map<String, dynamic> json) => ClassStats(
    type: json["type"],
    kills: json["kills"],
    assists: json["assists"],
    deaths: json["deaths"],
    dmg: json["dmg"],
    weapon: new Map.from(json["weapon"]).map((k, v) => new MapEntry<String, Weapon>(k, Weapon.fromJson(v))),
    totalTime: json["total_time"]
  );

}