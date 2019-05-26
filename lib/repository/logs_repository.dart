import 'package:dio/dio.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/logs_search_response.dart';

class LogsRepository{
  Dio dio = Dio();

  Future<Log> getLog(int logId) async{
    Uri uri = Uri.parse("http://logs.tf/json/$logId");
    Response response = await dio.request(uri.toString());
    print("Response: " + response.toString());
    return Log.fromJson(response.data);
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
}