import 'package:logstf/model/log.dart';
import 'package:logstf/model/logs_search_response.dart';
import 'package:logstf/repository/logs_repository.dart';

class LogsProvider{
  LogsRepository logsRepository = LogsRepository();

  Future<Log> getLog(int logId){
    return logsRepository.getLog(logId);
  }

  Future<LogsSearchResponse> searchLogs(){
    return logsRepository.searchLogs();
  }
}