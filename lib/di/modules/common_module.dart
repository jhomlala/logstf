import 'package:inject/inject.dart';
import 'package:logstf/repository/external/logs_player_search_provider.dart';
import 'package:logstf/repository/internal/app_state_manager.dart';
import 'package:logstf/repository/internal/logs_local_provider.dart';
import 'package:logstf/repository/internal/players_observed_local_provider.dart';
import 'package:logstf/repository/internal/settings_local_provider.dart';
import 'package:logstf/repository/external/logs_remote_provider.dart';
import 'package:logstf/repository/external/steam_remote_provider.dart';
import 'package:logstf/ui/about/page/about_page.dart';
import 'package:logstf/ui/help/page/help_page.dart';
import 'package:logstf/util/routing_helper.dart';
import 'package:logstf/ui/log/page/log_page.dart';
import 'package:logstf/ui/player/page/log_player_page.dart';
import 'package:logstf/ui/search/page/player_search_results_page.dart';
import 'package:logstf/ui/search/page/search_page.dart';
import 'package:logstf/ui/settings/page/settings_page.dart';
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
      SettingsPageProvider settingsPageProvider,
      HelpPageProvider helpPageProvider,
      AboutPageProvider aboutPageProvider) {
    return RoutingHelper(
        sailor,
        logViewProvider,
        searchPageProvider,
        playerSearchResultsPageProvider,
        logPlayerPageProvider,
        settingsPageProvider,
        helpPageProvider,
        aboutPageProvider);
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
  SettingsLocalProvider provideSettingsLocalProvider() {
    return SettingsLocalProvider();
  }

  @provide
  @singleton LogsSearchPlayerProvider provideLogsSearchPlayerProvider(){
    return LogsSearchPlayerProvider();
  }
}
