import 'package:dio/dio.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/model/external/logs_search_response.dart';
import 'package:logstf/repository/external/logs_remote_repository.dart';
import 'package:logstf/utils/app_const.dart';

class LogsRemoteProvider {
  LogsRemoteRepository _logsRepository;

  LogsRemoteProvider(Dio dio) {
    _logsRepository = LogsRemoteRepository(dio);
  }

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
