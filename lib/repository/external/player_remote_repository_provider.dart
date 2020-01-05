import 'package:dio/dio.dart';
import 'package:logstf/model/external/player_search_result.dart';

import 'player_remote_repository.dart';

class PlayerRemoteRepositoryProvider {
  PlayerRemoteRepository _repository;

  PlayerRemoteRepositoryProvider(Dio dio) {
    _repository = PlayerRemoteRepository(dio);
  }

  Future<List<PlayerSearchResult>> searchPlayers(String playerName) {
    return _repository.searchPlayers(playerName);
  }
}
