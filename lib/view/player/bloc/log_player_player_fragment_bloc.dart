import 'package:logstf/model/steam_player.dart';
import 'package:logstf/model/steam_players_response.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:logstf/repository/remote/steam_remote_provider.dart';
import 'package:logstf/view/common/base_bloc.dart';
import 'package:logstf/view/common/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class LogPlayerPlayerFragmentBloc extends BaseBloc {
  final LogsRemoteProvider logsRemoteProvider;
  final SteamRemoteProvider steamRemoteProvider;
  final BehaviorSubject<SteamPlayer> steamPlayerSubject = BehaviorSubject();

  LogPlayerPlayerFragmentBloc(
      this.logsRemoteProvider, this.steamRemoteProvider);

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
}

class LogPlayerPlayerFragmentBlocProvider
    extends BlocProvider<LogPlayerPlayerFragmentBloc> {
  final LogsRemoteProvider logsRemoteProvider;
  final SteamRemoteProvider steamRemoteProvider;

  LogPlayerPlayerFragmentBlocProvider(
      this.logsRemoteProvider, this.steamRemoteProvider);

  @override
  LogPlayerPlayerFragmentBloc create() {
    return LogPlayerPlayerFragmentBloc(logsRemoteProvider, steamRemoteProvider);
  }
}
