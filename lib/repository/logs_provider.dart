import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/repository/logs_repository.dart';

class LogsProvider{
  LogsRepository logsRepository = LogsRepository();

  Future<Log> getLog(int logId){
    return logsRepository.getLog(logId);
  }

  Future<LogsSearchResponse> searchLogs(String map, String uploader, String title, String player){
    return logsRepository.searchLogs(map,uploader,title,player);
  }

  void saveLog(Log log) async{
    await logsRepository.saveLog(log);
  }

  Future<LogShort> getSavedLog(int logId){
    return logsRepository.getSavedLog(logId);
  }
}