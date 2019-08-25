import 'package:logstf/model/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_repository.dart';

class PlayersObservedLocalProvider {
  PlayersObservedLocalRepository dbProvider = PlayersObservedLocalRepository.db;

  Future<int> createPlayerObserved(PlayerObserved playerObserved) {
    return dbProvider.createPlayerObserved(playerObserved);
  }

  Future<PlayerObserved> getPlayerObserved(int id) {
    return dbProvider.getPlayerObserved(id);
  }

  Future<PlayerObserved> getPlayerObservedWithSteamId64(String steamId64) {
    return dbProvider.getPlayerObservedWithSteamId64(steamId64);
  }

  Future<List<PlayerObserved>> getPlayersObserved() {
    return dbProvider.getPlayersObserved();
  }

  Future<int> deletePlayerObserved(int id) {
    return dbProvider.deletePlayerObserved(id);
  }

  Future<int> deletePlayersObserved(){
    return dbProvider.deletePlayersObserved();
  }

}

final PlayersObservedLocalProvider playersObservedLocalProvider =
    new PlayersObservedLocalProvider();
