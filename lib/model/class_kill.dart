class ClassKill {
  final int engineer;
  final int spy;
  final int scout;
  final int heavyweapons;
  final int pyro;
  final int demoman;
  final int sniper;
  final int soldier;
  final int medic;

  ClassKill(
      {this.engineer,
      this.spy,
      this.scout,
      this.heavyweapons,
      this.pyro,
      this.demoman,
      this.sniper,
      this.soldier,
      this.medic});

  factory ClassKill.fromJson(Map<String, dynamic> json) => ClassKill(
      engineer: json["engineer"],
      spy: json["spy"],
      scout: json["scout"],
      heavyweapons: json["heavyweapons"],
      pyro: json["pyro"],
      demoman: json["demoman"],
      sniper: json["sniper"],
      soldier: json["soldier"],
      medic: json["medic"]);

  @override
  String toString() {
    return 'ClassKill{engineer: $engineer, spy: $spy, scout: $scout, heavyweapons: $heavyweapons, pyro: $pyro, demoman: $demoman, sniper: $sniper, soldier: $soldier, medic: $medic}';
  }
}
