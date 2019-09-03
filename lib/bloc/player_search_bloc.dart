import 'package:logstf/model/player_search_result.dart';
import 'package:logstf/repository/remote/logs_player_search_provider.dart';
import 'package:rxdart/rxdart.dart';

class PlayerSearchBloc {
  final BehaviorSubject<List<PlayerSearchResult>> playersSearchSubject =
      BehaviorSubject();
  bool loading = false;

  void dispose() {
    playersSearchSubject.close();
  }

  void searchPlayers(String playerName) async {
    loading = true;
    var results = await logsSearchPlayerProvider.searchPlayers(playerName);
    playersSearchSubject.value = results;
    print("Search completed!");
    loading = false;
  }
}

final PlayerSearchBloc playerSearchBloc = PlayerSearchBloc();
