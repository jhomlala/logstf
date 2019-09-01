import 'package:logstf/model/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:rxdart/subjects.dart';

class PlayersObservedBloc {
  final BehaviorSubject<List<PlayerObserved>> playersObservedSubject =
      BehaviorSubject<List<PlayerObserved>>();
  PlayersObservedLocalProvider provider;
  bool loading = false;

  void dispose() {
    playersObservedSubject.close();
  }

  Future addPlayerObserved(PlayerObserved playerObserved) async {
    await playersObservedLocalProvider.createPlayerObserved(playerObserved);
    clearPlayersObserved();
    getPlayersObserved();
  }

  Future<PlayerObserved> getPlayerObserved(String steamId64) async {
    return await playersObservedLocalProvider
        .getPlayerObservedWithSteamId64(steamId64);
  }

  void deletePlayerObserved(int id) async {
    await playersObservedLocalProvider.deletePlayerObserved(id);
    clearPlayersObserved();
    getPlayersObserved();
  }

  void clearPlayersObserved() {
    playersObservedSubject.value = List();
  }

  void deletePlayersObserved() async {
    await playersObservedLocalProvider.deletePlayersObserved();
    clearPlayersObserved();
  }

  void getPlayersObserved() async {
    playersObservedSubject.value = await playersObservedLocalProvider.getPlayersObserved();
  }
}

final PlayersObservedBloc playersObservedBloc = new PlayersObservedBloc();
