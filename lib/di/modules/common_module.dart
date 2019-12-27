import 'package:inject/inject.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:logstf/util/routing_helper.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:logstf/view/search/page/player_search_results_page.dart';
import 'package:logstf/view/search/page/search_page.dart';
import 'package:sailor/sailor.dart';

@module
class CommonModule {
  @provide
  @singleton
  Sailor provideSailor() {
    return Sailor();
  }

  @provide
  @singleton
  RoutingHelper provideRoutingHelper(
      Sailor sailor,
      LogViewProvider logViewProvider,
      SearchPageProvider searchPageProvider,
      PlayerSearchResultsPageProvider playerSearchResultsPageProvider) {
    return RoutingHelper(sailor, logViewProvider, searchPageProvider,
        playerSearchResultsPageProvider);
  }

  @provide
  @singleton
  AppStateManager provideAppStateManager() {
    return AppStateManager();
  }

  @provide
  @singleton
  PlayersObservedLocalProvider providePlayersObservedLocalProvider() {
    return PlayersObservedLocalProvider();
  }

  @provide
  @singleton
  LogsRemoteProvider provideLogsRemoteProvider() {
    return LogsRemoteProvider();
  }

  @provide
  @singleton
  LogsLocalProvider provideLogsLocalProvider(){
    return LogsLocalProvider();
  }
}
