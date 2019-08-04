import 'package:flutter/material.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/logs_search_response.dart';
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
  }

  Future<int> getPlayerMatchesCount(String player) async {
    print("Selecting matches count for: " + player);
    var response = await logsRemoteProvider.searchLogs(null,null,null, player);
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

    var list = logsSearchSubject.value;
    if (list.length > 0 && list.where((log) => log.id == -1).isEmpty){
      list.insert(0,LogShort.placeholder());
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

  bool isAnyFilterActive(){
    return (map != null && map.isNotEmpty) || (uploader != null && uploader.isNotEmpty)
        || (title != null && title.isNotEmpty) || (player != null && player.isNotEmpty);
  }
}

final logsSearchBloc = LogsSearchBloc();
