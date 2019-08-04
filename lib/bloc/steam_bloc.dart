import 'package:logstf/model/steam_player.dart';
import 'package:logstf/model/steam_players_response.dart';
import 'package:logstf/repository/remote/steam_remote_provider.dart';
import 'package:rxdart/rxdart.dart';

class SteamBloc {
  SteamRemoteProvider _steamRemoteProvider = SteamRemoteProvider();

  BehaviorSubject<SteamPlayer> steamPlayerSubject = BehaviorSubject();

  getSteamPlayer(String steamId) async {
    steamPlayerSubject.value = null;
    SteamPlayersResponse response = await _steamRemoteProvider.getSteamPlayers(
        steamId);
    var players = response.response.players;
    if (players != null && players.length > 0) {
      steamPlayerSubject.value = players[0];
    }
  }

}

final steamBloc = new SteamBloc();