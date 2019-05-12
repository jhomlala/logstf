class Ubertypes {
  final int medigun;
  final int kritzkrieg;
  final int unknown;

  Ubertypes({this.medigun, this.kritzkrieg, this.unknown});

  factory Ubertypes.fromJson(Map<String, dynamic> json) => Ubertypes(
      medigun: json["medigun"],
      kritzkrieg: json["kritzkrieg"],
      unknown: json["unknown"]);
}
