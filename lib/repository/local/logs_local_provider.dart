import 'package:logstf/model/log_short.dart';

import 'logs_local_repository.dart';

class LogsLocalProvider{
  LogsLocalRepository dbProvider = LogsLocalRepository.db;

  Future<int> createLog(LogShort logShort){
    return dbProvider.createLog(logShort);
  }

  Future<LogShort> getLog(int logId){
    return dbProvider.getLog(logId);
  }

  Future<List<LogShort>> getLogs(){
    return dbProvider.getLogs();
  }

  Future<int> deleteLog(int logId){
    return dbProvider.deleteLog(logId);
  }

  Future<int> deleteLogs() {
    return dbProvider.deleteLogs();
  }

}
final logsLocalProvider = LogsLocalProvider();