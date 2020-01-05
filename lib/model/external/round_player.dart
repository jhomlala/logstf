class RoundPlayer {
  final String team;
  final int kills;
  final int dmg;

  RoundPlayer({this.team, this.kills, this.dmg});

  factory RoundPlayer.fromJson(Map<String, dynamic> json) =>
      RoundPlayer(team: json["team"], kills: json["kills"], dmg: json["dmg"]);

}