import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:rxdart/subjects.dart';

class LogsBloc {

  var logSubject = BehaviorSubject<Log>();
  var savedLogsSubject = BehaviorSubject<List<LogShort>>();
  var savedLogsLoading = false;

  void getLog(int logId) async {
    logSubject.value = await logsRemoteProvider.getLog(logId);
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

  void getSavedLogs() async{
    savedLogsLoading = true;
    savedLogsSubject.value = await logsLocalProvider.getLogs();
    savedLogsLoading = false;
  }


}

final logsBloc = LogsBloc();