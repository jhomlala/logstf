import 'package:logstf/model/log_short.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:rxdart/subjects.dart';

class LogsSavedBloc {
  final BehaviorSubject<List<LogShort>> savedLogsSubject = BehaviorSubject();
  var loading = false;

  void dispose() async {
    await savedLogsSubject.drain();
    savedLogsSubject.close();
  }

  void saveLog(LogShort log) {
    logsLocalProvider.createLog(log);
  }

  Future<LogShort> getSavedLog(int logId) {
    return logsLocalProvider.getLog(logId);
  }

  void deleteSavedLog(int logId) async {
    await logsLocalProvider.deleteLog(logId);
  }

  void getSavedLogs() async {
    savedLogsSubject.value = await logsLocalProvider.getLogs();
  }

  void initLogs() {
    if (loading) {
      return;
    }
    if (savedLogsSubject.value == null) {
      getSavedLogs();
    }
  }

  void addLog(LogShort logShort) {
    var savedLogs = savedLogsSubject.value;
    savedLogs.add(logShort);
    savedLogsSubject.add(savedLogs);
  }

  void removeLog(LogShort logShortToFind) {
    var savedLogs = savedLogsSubject.value;
    savedLogs.removeWhere((logShort) => logShort.id == logShortToFind.id);
    savedLogsSubject.value = savedLogs;
  }

  void clearLogs() {
    savedLogsSubject.value = List();
  }

  void deleteSavedLogs() async {
    await logsLocalProvider.deleteLogs();
    clearLogs();
  }
}

final logsSavedBloc = LogsSavedBloc();
