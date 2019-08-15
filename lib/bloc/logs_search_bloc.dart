
import 'package:logstf/model/log_short.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:rxdart/rxdart.dart';

class LogsSearchBloc {
  bool loading = false;
  final BehaviorSubject<List<LogShort>> logsSearchSubject = BehaviorSubject();
  String map = "";
  String uploader = "";
  String title = "";
  String player = "";

  void dispose() async {
    await logsSearchSubject.drain();
    logsSearchSubject.close();
  }

  clearLogs() {
    logsSearchSubject.value.clear();
    logsSearchSubject.value = new List<LogShort>();
  }

  Future<int> getPlayerMatchesCount(String player) async {
    print("Selecting matches count for: " + player);
    var response =
        await logsRemoteProvider.searchLogs(null, null, null, player);
    if (response != null) {
      print("Response is: " + response.toJson().toString());
      return response.total;
    } else {
      return 0;
    }
  }

  searchLogs({String map, String uploader, String title, String player}) async {
    print("search logs: $map, $uploader, $title, $player");
    this.map = map != null ? map : "";
    this.uploader = uploader != null ? uploader : "";
    this.title = title != null ? title : "";
    this.player = player != null ? player : "";

    loading = true;
    var response =
        await logsRemoteProvider.searchLogs(map, uploader, title, player);

    if (response != null) {
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
  }

  void initLogs() {
    if (loading) {
      print("logs are loading..");
      return;
    }
    if (logsSearchSubject.value == null) {
      print("Logs not present, selecting new....");
      searchLogs();
    } else {
      print("Logs are present!!!");
    }
  }

  bool isAnyFilterActive() {
    return (map != null && map.isNotEmpty) ||
        (uploader != null && uploader.isNotEmpty) ||
        (title != null && title.isNotEmpty) ||
        (player != null && player.isNotEmpty);
  }

  void clearFilters() {
    map = "";
    uploader = "";
    title = "";
    player = "";
    loading = true;
    clearLogs();
    searchLogs();
  }
}

final logsSearchBloc = LogsSearchBloc();
