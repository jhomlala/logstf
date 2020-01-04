import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/model/external/logs_search_response.dart';
import 'package:logstf/util/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogsRemoteRepository {
  Dio _dio = Dio();

  Future<Log> getLog(int logId) async {
    Uri uri = Uri.parse("${AppConst.baseLogsUrl}/json/$logId");
    Response response = await _dio.request(uri.toString());
    return Log.fromJson(response.data, logId);
  }

  Future<LogsSearchResponse> searchLogs(String map, String uploader,
      String title, String player, int offset, int limit) async {
    String url =
        buildSearchLogsUrl(offset, limit, map, uploader, title, player);
    Response response = await _dio.request(url);
    return LogsSearchResponse.fromJson(response.data);
  }

  String buildSearchLogsUrl(int offset, int limit, String map, String uploader,
      String title, String player) {
    String url = "${AppConst.baseLogsUrl}/api/v1/log?";
    if (offset != null) {
      url += "${AppConst.offsetUrlParameter}=$offset&";
    }
    if (limit != null) {
      url += "${AppConst.limitUrlParameter}=$limit&";
    }

    if (map != null) {
      url += "${AppConst.mapUrlParameter}=$map&";
    }
    if (uploader != null) {
      url += "${AppConst.uploaderUrlParameter}=$uploader&";
    }
    if (title != null) {
      url += "${AppConst.titleUrlParamter}=$title&";
    }
    if (player != null) {
      url += "${AppConst.playerUrlParameter}=$player&";
    }
    return url;
  }

  saveLog(Log log) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("log_${log.id}", json.encode(log.setupShortLog()));
  }

  Future<LogShort> getSavedLog(int logId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String logJson = prefs.getString("log_$logId");
    if (logJson != null) {
      Map<String, dynamic> map = json.decode(logJson);
      return LogShort.fromJson(map);
    }
    return null;
  }
}
