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
      engineer: json.containsKey("engineer") ? json["engineer"] : 0,
      spy: json.containsKey("spy") ? json["spy"] : 0,
      scout: json.containsKey("scout") ? json["scout"] : 0,
      heavyweapons: json.containsKey("heavyweapons") ? json["heavyweapons"] : 0,
      pyro: json.containsKey("pyro") ? json["pyro"] : 0,
      demoman: json.containsKey("demoman") ? json["demoman"] : 0,
      sniper: json.containsKey("sniper") ? json["sniper"] : 0,
      soldier: json.containsKey("soldier") ? json["soldier"] : 0,
      medic: json.containsKey("medic") ? json["medic"] : 0);

  @override
  String toString() {
    return 'ClassKill{engineer: $engineer, spy: $spy, scout: $scout, heavyweapons: $heavyweapons, pyro: $pyro, demoman: $demoman, sniper: $sniper, soldier: $soldier, medic: $medic}';
  }
}
