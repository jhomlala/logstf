import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:logstf/util/app_const.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/bloc_provider.dart';

class MainPageBloc {
  final BehaviorSubject<List<LogShort>> logsSearchSubject = BehaviorSubject();
  final BehaviorSubject<List<PlayerObserved>> playersObservedSubject =
  BehaviorSubject<List<PlayerObserved>>();

  int offset = 0;
  bool loading = false;
  bool error = false;
  String map = "";
  String uploader = "";
  String title = "";
  String player = "";


  void dispose() async {
    logsSearchSubject.close();
    playersObservedSubject.close();
  }

  void clearLogs() {
    if (logsSearchSubject.value != null) {
      logsSearchSubject.value.clear();
    }
    offset = 0;
    logsSearchSubject.value = new List<LogShort>();
  }

  Future<int> getPlayerMatchesCount(String player) async {
    var response = await logsRemoteProvider
        .searchLogs(null, null, null, player, null, limit: null);
    if (response != null) {
      return response.total;
    } else {
      return 0;
    }
  }

  Future searchLogsFromSearchData(SearchData searchData) {
    return searchLogs(
        map: searchData.map,
        uploader: searchData.uploader,
        title: searchData.title,
        player: searchData.player);
  }

  Future searchLogs({String map,
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

  void initLogs() {
    if (loading) {
      return;
    }

    if (logsSearchSubject.value == null) {
      searchLogs();
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


}

class MainPageBlocProvider extends BlocProvider<MainPageBloc> {

  @override
  MainPageBloc create() {
    return MainPageBloc();
  }
}

final MainPageBloc logsSearchBloc = MainPageBloc();
