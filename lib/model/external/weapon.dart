class Weapon {
  final int kills;
  final int dmg;
  final dynamic avgDmg;
  final int shots;
  final int hits;

  Weapon({this.kills, this.dmg, this.avgDmg, this.shots, this.hits});

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
      kills: json["kills"],
      dmg: json["dmg"],
      avgDmg: json["avg_dmg"],
      shots: json["shots"],
      hits: json["hits"]);
}
