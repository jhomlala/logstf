import 'package:logstf/bloc/bloc_provider.dart';
import 'package:logstf/model/internal/player_observed_added_event.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/model/player_search_result.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/remote/logs_player_search_provider.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:logstf/view/common/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PlayerSearchResultsPageBloc extends BaseBloc {
  final AppStateManager appStateManager;
  final PlayersObservedLocalProvider playersObservedLocalProvider;
  final BehaviorSubject<List<PlayerSearchResult>> playersSearchSubject =
      BehaviorSubject();
  final List<PlayerObserved> observedPlayers = List();
  String playerName;
  bool loading = false;

  PlayerSearchResultsPageBloc(
      this.appStateManager, this.playersObservedLocalProvider) {
    getObservedPlayers();
  }

  void searchPlayers() async {
    loading = true;
    var results = await logsSearchPlayerProvider.searchPlayers(playerName);
    playersSearchSubject.value = results;
    loading = false;
  }

  void observePlayer(PlayerSearchResult playerSearchResult) {
    playersObservedLocalProvider.createPlayerObserved(PlayerObserved(
        name: playerSearchResult.playerNames.first,
        steamid64: playerSearchResult.steamId));
    PlayerObserved playerObserved = PlayerObserved(
        name: playerSearchResult.playerNames.first,
        steamid64: playerSearchResult.steamId);
    observedPlayers.add(playerObserved);
    RxBus.post(PlayerObservedAddedEvent(playerObserved));
  }

  void getObservedPlayers() async {
    print("Get observed players!");
    List<PlayerObserved> observedPlayersList =
        await playersObservedLocalProvider.getPlayersObserved();
    observedPlayers.addAll(observedPlayersList);
  }

  @override
  void dispose() {
    playersSearchSubject.close();
  }

  bool isPlayerObserved(PlayerSearchResult playerSearchResult) {
    return observedPlayers
            .where((playerObserved) =>
                playerObserved.steamid64 == playerSearchResult.steamId)
            .length >
        0;
  }
}

class PlayerSearchResultsPageBlocProvider
    extends BlocProvider<PlayerSearchResultsPageBloc> {
  final AppStateManager appStateManager;
  final PlayersObservedLocalProvider playersObservedLocalProvider;

  PlayerSearchResultsPageBlocProvider(
      this.appStateManager, this.playersObservedLocalProvider);

  @override
  PlayerSearchResultsPageBloc create() {
    return PlayerSearchResultsPageBloc(
        appStateManager, this.playersObservedLocalProvider);
  }
}
