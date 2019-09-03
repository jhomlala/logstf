import 'package:logstf/model/player_search_result.dart';

import 'logs_player_search_repository.dart';

class LogsSearchPlayerProvider {
  LogsPlayerSearchRepository _repository = LogsPlayerSearchRepository();

  Future<List<PlayerSearchResult>> searchPlayers(String playerName) {
    return _repository.searchPlayers(playerName);
  }
}

final LogsSearchPlayerProvider logsSearchPlayerProvider =
    LogsSearchPlayerProvider();
