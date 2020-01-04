import 'dart:async';

import 'package:logstf/model/internal/players_observed_clear_event.dart';
import 'package:logstf/ui/common/bloc_provider.dart';
import 'package:logstf/model/internal/player_observed_added_event.dart';
import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/model/internal/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:logstf/ui/common/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LogsSavedPlayersFragmentBloc extends BaseBloc {
  final LogsRemoteProvider logsRemoteProvider;
  final PlayersObservedLocalProvider playersObservedLocalProvider;
  final BehaviorSubject<List<LogShort>> logsSearchSubject = BehaviorSubject();
  final BehaviorSubject<List<PlayerObserved>> playersObservedSubject =
      BehaviorSubject();

  bool loading = false;
  int offset = 0;

  LogsSavedPlayersFragmentBloc(
      this.logsRemoteProvider, this.playersObservedLocalProvider) {
    StreamSubscription playerAddedEventSubscription =
        RxBus.register<PlayerObservedAddedEvent>().listen((event) {
      List<PlayerObserved> playersObserved = playersObservedSubject.value;
      if (playersObserved == null) {
        playersObserved = List();
      }
      print("Player obseved added!");
      playersObserved.add(event.playerObserved);
      playersObservedSubject.add(playersObserved);
    });
    addSubscription(playerAddedEventSubscription);

    StreamSubscription playersClearEventSubscription = RxBus.register<PlayersObservedClearEvent>().listen((event){
      playersObservedSubject.value = List();
      logsSearchSubject.value = List();
      print("Players cleared!");
    });
    addSubscription(playersClearEventSubscription);

  }

  void getPlayersObserved() async {
    playersObservedSubject.value =
        await playersObservedLocalProvider.getPlayersObserved();
  }

  void deletePlayerObserved(PlayerObserved playerObserved) async {
    await playersObservedLocalProvider.deletePlayerObserved(playerObserved.id);
    List<PlayerObserved> playersObserved = playersObservedSubject.value;
    playersObserved.remove(playersObserved);
    getPlayersObserved();
  }

  void searchLogs(String playerSteamId64) async {
    try {
      loading = true;
      var response = await logsRemoteProvider.searchLogs(
          "", "", "", playerSteamId64, offset);

      if (response != null) {
        offset += AppConst.logsLimit;
        if (logsSearchSubject.value != null) {
          var list = List<LogShort>();
          list.addAll(logsSearchSubject.value);
          list.addAll(response.logs);
          logsSearchSubject.value = list;
        } else {
          logsSearchSubject.value = response.logs;
        }
      } else {
        logsSearchSubject.value = List<LogShort>();
      }

      loading = false;
    } catch (exception) {
      print("Exception ${exception.toString()}");
      loading = false;
      logsSearchSubject.addError(exception);
    }
  }

  void clearLogs() {
    if (logsSearchSubject.value != null) {
      logsSearchSubject.value.clear();
    }
    logsSearchSubject.value = List<LogShort>();
    offset = 0;
  }

  @override
  void dispose() {
    logsSearchSubject.close();
    playersObservedSubject.close();
  }
}

class LogsSavedPlayersFragmentBlocProvider
    extends BlocProvider<LogsSavedPlayersFragmentBloc> {
  final LogsRemoteProvider logsRemoteProvider;
  final PlayersObservedLocalProvider playersObservedLocalProvider;

  LogsSavedPlayersFragmentBlocProvider(
      this.logsRemoteProvider, this.playersObservedLocalProvider);

  @override
  LogsSavedPlayersFragmentBloc create() {
    return LogsSavedPlayersFragmentBloc(
        logsRemoteProvider, playersObservedLocalProvider);
  }
}
