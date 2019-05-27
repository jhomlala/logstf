import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:rxdart/subjects.dart';

class LogsBloc {
  LogsRemoteProvider logsProvider = LogsRemoteProvider();
  LogsLocalProvider logsLocalProvider = LogsLocalProvider();

  var logSubject = BehaviorSubject<Log>();

  void getLog(int logId) async {
    logSubject.value = await logsProvider.getLog(logId);
  }

  void saveLog(LogShort log){
    logsLocalProvider.createLog(log);
  }

  Future<LogShort> getSavedLog(int logId){
   return logsLocalProvider.getLog(logId);
  }

  void deleteSavedLog(int logId) async {
    var res = await logsLocalProvider.deleteLog(logId);
    print("Delete res: " + res.toString());
  }
}
