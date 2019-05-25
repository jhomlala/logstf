import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/repository/logs_provider.dart';
import 'package:rxdart/rxdart.dart';

class LogsSearchBloc {
  LogsProvider logsProvider = LogsProvider();
  final BehaviorSubject<
      LogsSearchResponse> logsSearchSubject = BehaviorSubject();

  void dispose() async {
    await logsSearchSubject.drain();
    logsSearchSubject.close();
  }

  searchLogs() async {
    logsSearchSubject.value = await logsProvider.searchLogs();
  }

}