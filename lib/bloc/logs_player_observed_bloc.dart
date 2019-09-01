import 'package:logstf/model/log_short.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:logstf/util/app_const.dart';
import 'package:rxdart/rxdart.dart';

class LogsPlayerObservedBloc {
  final BehaviorSubject<List<LogShort>> logsSearchSubject = BehaviorSubject();
  bool loading = false;
  int offset = 0;

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
}

final LogsPlayerObservedBloc logsPlayerObservedBloc = LogsPlayerObservedBloc();
