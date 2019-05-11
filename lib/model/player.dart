import 'package:logstf/model/class_stats.dart';

class Player {
  final String steamId;
  final String team;
  final List<ClassStats> classStats;
  final int kills;
  final int deaths;
  final int assists;
  final int suicides;
  final String kapd;
  final String kpd;
  final int dmg;
  final int dmgReal;
  final int dt;
  final int dtReal;
  final int hr;
  final int lks;
  final int as;
  final int dapd;
  final int dapm;
  final int ubers;
  final int drops;
  final int medkits;
  final int medkitsHp;
  final int backstabs;
  final int headshots;
  final int headshotsHit;
  final int sentries;
  final int heal;
  final int cpc;
  final int ic;

  Player(
      {this.steamId,
      this.team,
      this.classStats,
      this.kills,
      this.deaths,
      this.assists,
      this.suicides,
      this.kapd,
      this.kpd,
      this.dmg,
      this.dmgReal,
      this.dt,
      this.dtReal,
      this.hr,
      this.lks,
      this.as,
      this.dapd,
      this.dapm,
      this.ubers,
      this.drops,
      this.medkits,
      this.medkitsHp,
      this.backstabs,
      this.headshots,
      this.headshotsHit,
      this.sentries,
      this.heal,
      this.cpc,
      this.ic});

  factory Player.fromJson(Map<String, dynamic> json, String steamId) => Player(
      steamId: steamId,
      team: json["team"],
      classStats: (json["class_stats"] as List)
          .map((i) => new ClassStats.fromJson(i))
          .toList(),
      kills: json["kills"],
      deaths: json["deaths"],
      assists: json["assists"],
      suicides: json["suicides"],
      kapd: json["kapd"],
      kpd: json["kpd"],
      dmg: json["dmg"],
      dmgReal: json["dmg_real"],
      dt: json["dt"],
      dtReal: json["dt_real"],
      hr: json["hr"],
      lks: json["lks"],
      as: json["as"],
      dapd: json["dapd"],
      dapm: json["dapm"],
      ubers: json["ubers"],
      drops: json["drops"],
      medkits: json["medkits"],
      medkitsHp: json["medkits_hp"],
      backstabs: json["backstabs"],
      headshots: json["headshots"],
      headshotsHit: json["headshots_hit"],
      sentries: json["sentries"],
      heal: json["heal"],
      cpc: json["cpc"],
      ic: json["ic"]);
}
