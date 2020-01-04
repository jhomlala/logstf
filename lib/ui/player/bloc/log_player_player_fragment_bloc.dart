import 'package:logstf/model/internal/player_observed_added_event.dart';
import 'package:logstf/model/internal/player_observed.dart';
import 'package:logstf/model/external/steam_player.dart';
import 'package:logstf/model/external/steam_players_response.dart';
import 'package:logstf/repository/internal/players_observed_local_provider.dart';
import 'package:logstf/repository/external/logs_remote_provider.dart';
import 'package:logstf/repository/external/steam_remote_provider.dart';
import 'package:logstf/ui/common/base_bloc.dart';
import 'package:logstf/ui/common/bloc_provider.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:rxdart/rxdart.dart';

class LogPlayerPlayerFragmentBloc extends BaseBloc {
  final LogsRemoteProvider logsRemoteProvider;
  final SteamRemoteProvider steamRemoteProvider;
  final PlayersObservedLocalProvider playersObservedLocalProvider;
  final BehaviorSubject<SteamPlayer> steamPlayerSubject = BehaviorSubject();

  LogPlayerPlayerFragmentBloc(this.logsRemoteProvider, this.steamRemoteProvider,
      this.playersObservedLocalProvider);

  void dispose() {
    super.dispose();
    steamPlayerSubject.close();
  }

  Future<int> getPlayerMatchesCount(String player) async {
    var response = await logsRemoteProvider
        .searchLogs(null, null, null, player, null, limit: null);
    if (response != null) {
      return response.total;
    } else {
      return 0;
    }
  }

  void getSteamPlayer(String steamId) async {
    try {
      steamPlayerSubject.value = null;
      SteamPlayersResponse response =
          await steamRemoteProvider.getSteamPlayers(steamId);
      var players = response.response.players;
      if (players != null && players.length > 0) {
        steamPlayerSubject.value = players[0];
      }
    } catch (exception, stackTrace) {
      steamPlayerSubject.addError(exception);
    }
  }

  Future<PlayerObserved> getPlayerObserved(String steamId64) async {
    return playersObservedLocalProvider
        .getPlayerObservedWithSteamId64(steamId64);
  }

  Future observePlayer(String steamId64, String playerName) async {
    PlayerObserved playerObserved = await getPlayerObserved(steamId64);
    if (playerObserved == null) {
      playerObserved = PlayerObserved(
          id: DateTime.now().millisecondsSinceEpoch,
          name: playerName,
          steamid64: steamId64);
      await playersObservedLocalProvider.createPlayerObserved(playerObserved);
      RxBus.post(PlayerObservedAddedEvent(playerObserved));
    }
  }

  Future removeObservedPlayer(String steamId64) async {
    PlayerObserved playerObserved = await playersObservedLocalProvider
        .getPlayerObservedWithSteamId64(steamId64);
    await playersObservedLocalProvider.deletePlayerObserved(playerObserved.id);
  }
}

class LogPlayerPlayerFragmentBlocProvider
    extends BlocProvider<LogPlayerPlayerFragmentBloc> {
  final LogsRemoteProvider logsRemoteProvider;
  final SteamRemoteProvider steamRemoteProvider;
  final PlayersObservedLocalProvider playersObservedLocalProvider;

  LogPlayerPlayerFragmentBlocProvider(this.logsRemoteProvider,
      this.steamRemoteProvider, this.playersObservedLocalProvider);

  @override
  LogPlayerPlayerFragmentBloc create() {
    return LogPlayerPlayerFragmentBloc(
        logsRemoteProvider, steamRemoteProvider, playersObservedLocalProvider);
  }
}
