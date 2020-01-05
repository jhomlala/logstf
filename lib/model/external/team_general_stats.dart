class TeamGeneralStats{
  final int score;
  final int kills;
  final int deaths;
  final int dmg;
  final int charges;
  final int drops;
  final int firstCaps;
  final int caps;

  TeamGeneralStats({this.score, this.kills, this.deaths, this.dmg, this.charges, this.drops, this.firstCaps, this.caps});
  factory TeamGeneralStats.fromJson(Map<String, dynamic> json) => TeamGeneralStats(
    score: json["score"],
    kills: json["kills"],
    deaths: json["deaths"],
    dmg: json["dmg"],
    charges: json["charges"],
    drops: json["drops"],
    firstCaps: json["firstcaps"],
    caps: json["caps"]
  );

}