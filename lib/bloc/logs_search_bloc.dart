import 'package:flutter/material.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/repository/logs_provider.dart';
import 'package:rxdart/rxdart.dart';

class LogsSearchBloc with ChangeNotifier {
  LogsProvider logsProvider = LogsProvider();
  bool loading = false;
  final BehaviorSubject<List<LogShort>> logsSearchSubject =
      BehaviorSubject();
  String map = "";
  String uploader = "";
  String title = "";
  String player = "";

  void dispose() async {
    await logsSearchSubject.drain();
    logsSearchSubject.close();
    super.dispose();
  }

  clearLogs() {
    logsSearchSubject.value.clear();
  }


  searchLogs({String map, String uploader, String title, String player}) async {
    print("search logs: $map, $uploader, $title, $player");
    this.map = map != null ? map : "";
    this.uploader = uploader != null ? uploader : "";
    this.title = title != null ? title : "";
    this.player = player != null ? player : "";

    loading = true;
    var response = await logsProvider.searchLogs(map, uploader, title, player);
    if (response != null) {
      if (logsSearchSubject.value != null) {
        print("added logs 1");
        var list = List<LogShort>();
        list.addAll(logsSearchSubject.value);
        list.addAll(response.logs);
        logsSearchSubject.value = list;
      } else {
        print("added logs 2");
        logsSearchSubject.value = response.logs;
      }
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
}
