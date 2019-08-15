import 'package:logstf/model/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';

class PlayersObservedBloc {
  PlayersObservedLocalProvider provider;
  bool loading = false;

  addPlayerObserved(PlayerObserved playerObserved) async {
    await playersObservedLocalProvider.createPlayerObserved(playerObserved);
  }

  Future<PlayerObserved> getPlayerObserved(String steamId64) async{
    return await playersObservedLocalProvider.getPlayerObservedWithSteamId64(steamId64);
  }

  deletePlayerObserved(int id) async{
    await playersObservedLocalProvider.deletePlayerObserved(id);
  }

}

PlayersObservedBloc playersObservedBloc = new PlayersObservedBloc();
