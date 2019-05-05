import 'package:logstf/model/team_general_stats.dart';

class Teams {
  final TeamGeneralStats red;
  final TeamGeneralStats blue;

  Teams({this.red, this.blue});

  factory Teams.fromJson(Map<String, dynamic> json) => new Teams(
      red: TeamGeneralStats.fromJson(json["Red"]),
      blue: TeamGeneralStats.fromJson(json["Blue"]));
}
