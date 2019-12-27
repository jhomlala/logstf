import 'package:logstf/model/internal/search_data.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:logstf/util/app_const.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/bloc_provider.dart';

class MainPageBloc {
  Future<int> getPlayerMatchesCount(String player) async {
    var response = await logsRemoteProvider
        .searchLogs(null, null, null, player, null, limit: null);
    if (response != null) {
      return response.total;
    } else {
      return 0;
    }
  }
}

class MainPageBlocProvider extends BlocProvider<MainPageBloc> {
  @override
  MainPageBloc create() {
    return MainPageBloc();
  }
}

final MainPageBloc logsSearchBloc = MainPageBloc();
