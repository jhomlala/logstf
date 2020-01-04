class WatchedPlayer {
  final String steamId;
  final String name;

  WatchedPlayer(this.steamId, this.name);

  factory WatchedPlayer.fromJson(Map<String, dynamic> json) =>
      WatchedPlayer(json["steamId"], json["name"]);

  Map<String, dynamic> toJson() => {"steamId": steamId, "name": name};
}
