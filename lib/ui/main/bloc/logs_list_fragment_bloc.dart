import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/model/internal/log_short.dart';
import 'package:logstf/repository/external/logs_remote_provider.dart';
import 'package:logstf/util/app_const.dart';
import 'package:logstf/ui/common/base_bloc.dart';
import 'package:logstf/ui/common/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class LogsListFragmentBloc extends BaseBloc {
  final BehaviorSubject<List<LogShort>> logsSearchSubject = BehaviorSubject();
  final LogsRemoteProvider logsRemoteProvider;
  int offset = 0;
  bool loading = false;
  bool error = false;
  String map = "";
  String uploader = "";
  String title = "";
  String player = "";

  LogsListFragmentBloc(this.logsRemoteProvider);

  void initLogs() {
    if (loading) {
      return;
    }

    if (logsSearchSubject.value == null) {
      searchLogs();
    }
  }

  Future searchLogsFromSearchData(SearchData searchData) {
    return searchLogs(
        map: searchData.map,
        uploader: searchData.uploader,
        title: searchData.title,
        player: searchData.player);
  }

  Future searchLogs(
      {String map,
      String uploader,
      String title,
      String player,
      bool clearLogs = false}) async {
    try {
      if (clearLogs) {
        logsSearchSubject.value.clear();
        offset = 0;
      }

      this.map = map != null ? map : "";
      this.uploader = uploader != null ? uploader : "";
      this.title = title != null ? title : "";
      this.player = player != null ? player : "";

      loading = true;
      var response = await logsRemoteProvider.searchLogs(
          map, uploader, title, player, offset);

      if (response != null) {
        offset += AppConst.logsLimit;
        if (logsSearchSubject.value != null) {
          var list = List<LogShort>();
          list.addAll(logsSearchSubject.value);
          list.addAll(response.logs);
          logsSearchSubject.value = list;
        } else {
          logsSearchSubject.value = response.logs;
        }
      } else {
        var list = List<LogShort>();
        logsSearchSubject.value = list;
      }

      loading = false;
    } catch (exception) {
      loading = false;
      logsSearchSubject.addError(exception);
    }
  }

  bool isAnyFilterActive() {
    return (map != null && map.isNotEmpty) ||
        (uploader != null && uploader.isNotEmpty) ||
        (title != null && title.isNotEmpty) ||
        (player != null && player.isNotEmpty);
  }

  void clearFilters() {
    map = "";
    uploader = "";
    title = "";
    player = "";
    loading = true;
    clearLogs();
  }

  void clearLogs() {
    if (logsSearchSubject.value != null) {
      logsSearchSubject.value.clear();
    }
    offset = 0;
    logsSearchSubject.value = new List<LogShort>();
  }
}

class LogsListFragmentBlocProvider extends BlocProvider<LogsListFragmentBloc> {
  final LogsRemoteProvider logsRemoteProvider;

  LogsListFragmentBlocProvider(this.logsRemoteProvider);

  @override
  LogsListFragmentBloc create() {
    return LogsListFragmentBloc(logsRemoteProvider);
  }
}
