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

  Future<LogsSearchResponse> searchLogs() async {
    Uri uri = Uri.parse("http://logs.tf/api/v1/log");
    Response response = await dio.request(uri.toString());
    return LogsSearchResponse.fromJson(response.data);
  }
}