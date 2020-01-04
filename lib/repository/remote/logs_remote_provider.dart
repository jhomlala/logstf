import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/model/external/logs_search_response.dart';
import 'package:logstf/repository/remote/logs_remote_repository.dart';
import 'package:logstf/util/app_const.dart';

class LogsRemoteProvider {
  LogsRemoteRepository _logsRepository = LogsRemoteRepository();

  Future<Log> getLog(int logId) {
    return _logsRepository.getLog(logId);
  }

  Future<LogsSearchResponse> searchLogs(
      String map, String uploader, String title, String player, int offset,
      {int limit = AppConst.logsLimit}) {
    return _logsRepository.searchLogs(
        map, uploader, title, player, offset, limit);
  }

  void saveLog(Log log) async {
    await _logsRepository.saveLog(log);
  }

  Future<LogShort> getSavedLog(int logId) {
    return _logsRepository.getSavedLog(logId);
  }
}

final logsRemoteProvider = LogsRemoteProvider();
