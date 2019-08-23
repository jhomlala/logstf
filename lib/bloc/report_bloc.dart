import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:rxdart/rxdart.dart';

class ReportBloc {
  BehaviorSubject statusSubject = BehaviorSubject<int>();
  List<LogShort> shortLogs;
  List<Log> logs;
  BehaviorSubject logsSelectedCount = BehaviorSubject<int>();
  int index = 0;

  void startReportCollector(String steamId) {
    statusSubject.value = 1;
    shortLogs = List();
    logs = List();
    print("Start report collector");
    getLogs(steamId);
  }

  void getLogs(String playerSteamId64) async {
    var response =
        await logsRemoteProvider.searchLogs("", "", "", playerSteamId64);
    if (response != null) {
      print("Got logs!");
      shortLogs = response.logs;
      statusSubject.value = 2;
      getLogsDetails();
    }
  }


  void getLogsDetails(){
    if (shortLogs.length > index) {
      getLog(shortLogs[index].id);
    } else{
      print("End!");
    }

    /*shortLogs.forEach((LogShort logShort)async {
     Log log = await getLog(logShort.id);
    });*/
  }

  Future<Log> getLog(int logId) async {
    print("Get log: " + logId.toString());
    try {
      Log log = await logsRemoteProvider.getLog(logId);
      print("Log selected!!");
      logs.add(log);

      _onLogSelected();
      return log;
    } catch (exc){
      if (exc is DioError){
        print("Headers:" + exc.response.headers.toString());
      }
      print(exc);
      _onLogSelected();
      return null;
    }
  }

  _onLogSelected(){
    Timer(Duration(milliseconds: 100), (){
      index++;
      logsSelectedCount.value = logs.length;
      getLogsDetails();
    });

  }


}

final ReportBloc reportBloc = ReportBloc();
