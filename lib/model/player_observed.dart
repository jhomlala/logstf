class PlayerObserved{
  final int id;
  final String name;
  final String steamid64;

  PlayerObserved({this.id,this.name, this.steamid64});

  factory PlayerObserved.fromJson(Map<String, dynamic> json) => new PlayerObserved(
    id: json["id"],
    name: json["name"],
    steamid64: json["steamid64"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "steamid64": steamid64,
  };
}