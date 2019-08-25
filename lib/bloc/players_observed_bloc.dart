import 'package:logstf/model/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:rxdart/subjects.dart';

class PlayersObservedBloc {
  PlayersObservedLocalProvider provider;
  bool loading = false;

  var playersObservedSubject = BehaviorSubject<List<PlayerObserved>>();




  addPlayerObserved(PlayerObserved playerObserved) async {
    await playersObservedLocalProvider.createPlayerObserved(playerObserved);
    clearPlayersObserved();
    getPlayersObserved();
  }

  Future<PlayerObserved> getPlayerObserved(String steamId64) async{
    return await playersObservedLocalProvider.getPlayerObservedWithSteamId64(steamId64);
  }

  deletePlayerObserved(int id) async{
    await playersObservedLocalProvider.deletePlayerObserved(id);
    clearPlayersObserved();
    getPlayersObserved();
  }

  clearPlayersObserved(){
    playersObservedSubject.value = List();
  }

  deletePlayersObserved() async{
    await playersObservedLocalProvider.deletePlayersObserved();
    clearPlayersObserved();
  }

  getPlayersObserved() async {
    var list = await playersObservedLocalProvider.getPlayersObserved();
    playersObservedSubject.value = list;
  }

}

PlayersObservedBloc playersObservedBloc = new PlayersObservedBloc();
