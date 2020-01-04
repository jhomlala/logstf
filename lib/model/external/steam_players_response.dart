import 'package:logstf/model/external/steam_players.dart';

class SteamPlayersResponse {
  SteamPlayers response;

  SteamPlayersResponse({
    this.response,
  });

  factory SteamPlayersResponse.fromJson(Map<String, dynamic> json) => new SteamPlayersResponse(
    response: SteamPlayers.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}