import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';

class LogDetailsBloc {
  BehaviorSubject<Log> logSubject;
  BehaviorSubject<Player> selectedPlayerSubject;

  init(){
    logSubject = BehaviorSubject();
    selectedPlayerSubject = BehaviorSubject();
  }

  void dispose() async {
    logSubject.close();
    selectedPlayerSubject.close();
  }

  void selectLog(int logId) async{
    try {
      logSubject.value = await logsRemoteProvider.getLog(logId);
    } catch (exception){
      logSubject.addError(exception);
    }
  }

  void setLog(Log log) {
    logSubject.value = log;
  }

  void setPlayer(Player player) {
    selectedPlayerSubject.value = player;
  }

  void createLogInDatabase(LogShort log){
    logsLocalProvider.createLog(log);
  }

  Future<LogShort> getLogFromDatabase(int logId){
    return logsLocalProvider.getLog(logId);
  }

  void deleteLogFromDatabase(int logId) async {
    await logsLocalProvider.deleteLog(logId);
  }

}

final logDetailsBloc = LogDetailsBloc();
