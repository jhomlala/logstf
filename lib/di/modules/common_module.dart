import 'package:inject/inject.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/local/settings_local_provider.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:logstf/repository/remote/steam_remote_provider.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:logstf/util/routing_helper.dart';
import 'package:logstf/view/log/page/log_page.dart';
import 'package:logstf/view/player/page/log_player_page.dart';
import 'package:logstf/view/search/page/player_search_results_page.dart';
import 'package:logstf/view/search/page/search_page.dart';
import 'package:logstf/view/settings/page/settings_page.dart';
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
      PlayerSearchResultsPageProvider playerSearchResultsPageProvider,
      LogPlayerPageProvider logPlayerPageProvider,
      SettingsPageProvider settingsPageProvider) {
    return RoutingHelper(
        sailor,
        logViewProvider,
        searchPageProvider,
        playerSearchResultsPageProvider,
        logPlayerPageProvider,
        settingsPageProvider);
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
  LogsLocalProvider provideLogsLocalProvider() {
    return LogsLocalProvider();
  }

  @provide
  @singleton
  SteamRemoteProvider provideSteamRemoteProvider() {
    return SteamRemoteProvider();
  }

  @provide
  @singleton
  SettingsLocalProvider provideSettingsLocalProvider(){
    return SettingsLocalProvider();
  }
}
