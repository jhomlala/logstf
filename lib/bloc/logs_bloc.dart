import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/repository/logs_provider.dart';
import 'package:rxdart/subjects.dart';

class LogsBloc {
  LogsProvider logsProvider = LogsProvider();

  var logSubject = BehaviorSubject<Log>();

  void getLog(int logId) async {
    logSubject.value = await logsProvider.getLog(logId);
  }

  void saveLog(Log log){
    logsProvider.saveLog(log);
  }

  Future<LogShort> getSavedLog(int logId){
    return logsProvider.getSavedLog(logId);
  }
}
