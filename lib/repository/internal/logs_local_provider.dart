import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/repository/internal/app_database_provider.dart';

import 'logs_local_repository.dart';

class LogsLocalProvider {
  LogsLocalRepository _logsLocalRepository;

  LogsLocalProvider(AppDatabase appDatabase) {
    _logsLocalRepository = LogsLocalRepository(appDatabase);
  }

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

  Future<int> getLogsCount() {
    return _logsLocalRepository.getLogsCount();
  }
}
