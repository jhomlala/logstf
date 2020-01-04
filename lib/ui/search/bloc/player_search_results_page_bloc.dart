import 'package:logstf/ui/common/bloc_provider.dart';
import 'package:logstf/model/internal/player_observed_added_event.dart';
import 'package:logstf/model/internal/player_observed.dart';
import 'package:logstf/model/external/player_search_result.dart';
import 'package:logstf/repository/internal/app_state_manager.dart';
import 'package:logstf/repository/internal/players_observed_local_provider.dart';
import 'package:logstf/repository/external/player_remote_repository_provider.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:logstf/ui/common/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PlayerSearchResultsPageBloc extends BaseBloc {
  final AppStateManager appStateManager;
  final PlayersObservedLocalProvider playersObservedLocalProvider;
  final PlayerRemoteRepositoryProvider logsSearchPlayerProvider;
  final BehaviorSubject<List<PlayerSearchResult>> playersSearchSubject =
      BehaviorSubject();
  final List<PlayerObserved> observedPlayers = List();
  String playerName;
  bool loading = false;

  PlayerSearchResultsPageBloc(this.appStateManager,
      this.playersObservedLocalProvider, this.logsSearchPlayerProvider) {
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
  final PlayerRemoteRepositoryProvider logsSearchPlayerProvider;

  PlayerSearchResultsPageBlocProvider(this.appStateManager,
      this.playersObservedLocalProvider, this.logsSearchPlayerProvider);

  @override
  PlayerSearchResultsPageBloc create() {
    return PlayerSearchResultsPageBloc(appStateManager,
        this.playersObservedLocalProvider, this.logsSearchPlayerProvider);
  }
}
