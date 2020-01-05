import 'package:logstf/model/external/steam_player.dart';

class SteamPlayers{
  List<SteamPlayer> players;

  SteamPlayers({
    this.players,
  });

  factory SteamPlayers.fromJson(Map<String, dynamic> json) => SteamPlayers(
    players:  List<SteamPlayer>.from(json["players"].map((x) => SteamPlayer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "players":  List<dynamic>.from(players.map((x) => x.toJson())),
  };

}