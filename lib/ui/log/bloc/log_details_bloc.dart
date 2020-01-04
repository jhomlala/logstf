import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/repository/internal/logs_local_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logstf/repository/external/logs_remote_provider.dart';

import '../../common/bloc_provider.dart';

class LogDetailsBloc {
  final LogsRemoteProvider logsRemoteProvider;
  final LogsLocalProvider logsLocalProvider;
  BehaviorSubject<Log> logSubject = BehaviorSubject();
  BehaviorSubject<Player> selectedPlayerSubject = BehaviorSubject();

  LogDetailsBloc(this.logsRemoteProvider, this.logsLocalProvider);

  void init(){
    logSubject = BehaviorSubject();
    selectedPlayerSubject = BehaviorSubject();
  }

  void dispose() async {
    logSubject.close();
    selectedPlayerSubject.close();
  }

  void selectLog(int logId) async {
    try {
      logSubject.value = await logsRemoteProvider.getLog(logId);
    } catch (exception) {
      logSubject.addError(exception);
    }
  }

  void setLog(Log log) {
    logSubject.value = log;
  }

  void setPlayer(Player player) {
    selectedPlayerSubject.value = player;
  }

  void createLogInDatabase(LogShort log) {
    logsLocalProvider.createLog(log);
  }

  Future<LogShort> getLogFromDatabase(int logId) {
    return logsLocalProvider.getLog(logId);
  }

  void deleteLogFromDatabase(int logId) async {
    await logsLocalProvider.deleteLog(logId);
  }
}

class LogDetailsBlocProvider extends BlocProvider<LogDetailsBloc>{
  final LogsRemoteProvider logsRemoteProvider;
  final LogsLocalProvider logsLocalProvider;

  LogDetailsBlocProvider(this.logsRemoteProvider, this.logsLocalProvider);

  @override
  LogDetailsBloc create() {
    return LogDetailsBloc(logsRemoteProvider, logsLocalProvider);
  }
}

