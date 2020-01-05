import 'package:logstf/model/external/team_general_stats.dart';

class Teams {
  final TeamGeneralStats red;
  final TeamGeneralStats blue;

  Teams({this.red, this.blue});

  factory Teams.fromJson(Map<String, dynamic> json) =>  Teams(
      red: TeamGeneralStats.fromJson(json["Red"]),
      blue: TeamGeneralStats.fromJson(json["Blue"]));
}
