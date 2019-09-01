import 'package:logstf/model/steam_player.dart';
import 'package:logstf/model/steam_players_response.dart';
import 'package:logstf/repository/remote/steam_remote_provider.dart';
import 'package:rxdart/rxdart.dart';

class SteamBloc {
  final BehaviorSubject<SteamPlayer> steamPlayerSubject = BehaviorSubject();

  void dispose() {
    steamPlayerSubject.close();
  }

  void getSteamPlayer(String steamId) async {
    steamPlayerSubject.value = null;
    SteamPlayersResponse response =
        await steamRemoteProvider.getSteamPlayers(steamId);
    var players = response.response.players;
    if (players != null && players.length > 0) {
      steamPlayerSubject.value = players[0];
    }
  }
}

final SteamBloc steamBloc = new SteamBloc();
