import 'package:logstf/bloc/bloc_provider.dart';
import 'package:logstf/model/player_search_result.dart';
import 'package:logstf/repository/remote/logs_player_search_provider.dart';
import 'package:logstf/view/common/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PlayerSearchResultsPageBloc extends BaseBloc {
  final BehaviorSubject<List<PlayerSearchResult>> playersSearchSubject =
      BehaviorSubject();
  String playerName;
  bool loading = false;

  void searchPlayers() async {
    print("Search players: " + playerName);
    loading = true;
    var results = await logsSearchPlayerProvider.searchPlayers(playerName);
    playersSearchSubject.value = results;
    loading = false;
  }

  @override
  void dispose() {
    playersSearchSubject.close();
  }
}

class PlayerSearchResultsPageBlocProvider
    extends BlocProvider<PlayerSearchResultsPageBloc> {
  @override
  PlayerSearchResultsPageBloc create() {
    return PlayerSearchResultsPageBloc();
  }
}
