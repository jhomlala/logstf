import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogsRepository{
  Dio dio = Dio();


  Future<Log> getLog(int logId) async{
    Uri uri = Uri.parse("http://logs.tf/json/$logId");
    Response response = await dio.request(uri.toString());
    print("Response: " + response.toString());
    return Log.fromJson(response.data, logId);
  }

  Future<LogsSearchResponse> searchLogs(String map, String uploader, String title, String player) async {
    String url = "http://logs.tf/api/v1/log?";
    if (map != null){
      url+="map=$map&";
    }
    if (uploader != null){
      url+="map=$uploader&";
    }
    if (title != null){
      url+="map=$title&";
    }
    if (player != null){
      url+="map=$player&";
    }

    Uri uri = Uri.parse(url);

    Response response = await dio.request(uri.toString());
    print("Got response from server: " + response.statusCode.toString());
    return LogsSearchResponse.fromJson(response.data);
  }

  saveLog(Log log) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("log_${log.id}", json.encode(log.setupShortLog()));
  }

  Future<LogShort> getSavedLog(int logId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String logJson = prefs.getString("log_$logId");
    if (logJson != null){
      Map<String,dynamic> map = json.decode(logJson);
      return LogShort.fromJson(map);
    }
    return null;
  }


}