import 'package:dio/dio.dart';
import 'package:logstf/model/log.dart';

class LogsRepository{
  Dio dio = Dio();

  Future<Log> getLog(int logId) async{
    Uri uri = Uri.parse("http://logs.tf/json/$logId");
    Response response = await dio.request(uri.toString());
    print("Response: " + response.toString());
    return Log.fromJson(response.data);
  }
}