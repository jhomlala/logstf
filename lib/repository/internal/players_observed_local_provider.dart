import 'package:logstf/model/internal/player_observed.dart';
import 'package:logstf/repository/internal/app_database_provider.dart';
import 'package:logstf/repository/internal/players_observed_local_repository.dart';

class PlayersObservedLocalProvider {
  PlayersObservedLocalRepository _playersObservedLocalRepository;

  PlayersObservedLocalProvider(AppDatabase appDatabase) {
    _playersObservedLocalRepository =
        PlayersObservedLocalRepository(appDatabase);
  }

  Future<int> createPlayerObserved(PlayerObserved playerObserved) {
    return _playersObservedLocalRepository.createPlayerObserved(playerObserved);
  }

  Future<PlayerObserved> getPlayerObserved(int id) {
    return _playersObservedLocalRepository.getPlayerObserved(id);
  }

  Future<PlayerObserved> getPlayerObservedWithSteamId64(String steamId64) {
    return _playersObservedLocalRepository
        .getPlayerObservedWithSteamId64(steamId64);
  }

  Future<List<PlayerObserved>> getPlayersObserved() {
    return _playersObservedLocalRepository.getPlayersObserved();
  }

  Future<int> deletePlayerObserved(int id) {
    return _playersObservedLocalRepository.deletePlayerObserved(id);
  }

  Future<int> deletePlayersObserved() {
    return _playersObservedLocalRepository.deletePlayersObserved();
  }

  Future<int> getPlayersObservedCount() {
    return _playersObservedLocalRepository.getPlayersObservedCount();
  }
}
