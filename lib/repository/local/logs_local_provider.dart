import 'package:logstf/model/log_short.dart';

import 'logs_local_repository.dart';

class LogsLocalProvider {
  LogsLocalRepository _logsLocalRepository = LogsLocalRepository.db;

  Future<int> createLog(LogShort logShort) {
    return _logsLocalRepository.createLog(logShort);
  }

  Future<LogShort> getLog(int logId) {
    return _logsLocalRepository.getLog(logId);
  }

  Future<List<LogShort>> getLogs() {
    return _logsLocalRepository.getLogs();
  }

  Future<int> deleteLog(int logId) {
    return _logsLocalRepository.deleteLog(logId);
  }

  Future<int> deleteLogs() {
    return _logsLocalRepository.deleteLogs();
  }
}

final LogsLocalProvider logsLocalProvider = LogsLocalProvider();
