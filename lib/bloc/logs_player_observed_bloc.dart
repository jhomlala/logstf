import 'package:logstf/model/log_short.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:rxdart/rxdart.dart';

class LogsPlayerObservedBloc {
  bool loading = false;
  int offset = 0;
  final BehaviorSubject<List<LogShort>> logsSearchSubject = BehaviorSubject();

  searchLogs(String playerSteamId64) async {
    try {
      loading = true;
      var response =
          await logsRemoteProvider.searchLogs("", "", "", playerSteamId64, offset);

      if (response != null)  {
        offset += 1000;
        if (logsSearchSubject.value != null) {
          var list = List<LogShort>();
          list.addAll(logsSearchSubject.value);
          list.addAll(response.logs);
          logsSearchSubject.value = list;
        } else {
          logsSearchSubject.value = response.logs;
        }
      } else {
        var list = List<LogShort>();
        logsSearchSubject.value = list;
      }

      loading = false;
    } catch (exception) {
      loading = false;
      logsSearchSubject.addError(exception);
    }
  }

  clearLogs(){
    if (logsSearchSubject.value != null){
      logsSearchSubject.value.clear();
    }
    logsSearchSubject.value = List<LogShort>();
    offset = 0;
  }
}

final LogsPlayerObservedBloc logsPlayerObservedBloc = LogsPlayerObservedBloc();
