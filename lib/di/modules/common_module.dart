import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:logstf/repository/external/player_remote_repository_provider.dart';
import 'package:logstf/repository/internal/app_database_provider.dart';
import 'package:logstf/repository/internal/app_state_manager.dart';
import 'package:logstf/repository/internal/logs_local_provider.dart';
import 'package:logstf/repository/internal/players_observed_local_provider.dart';
import 'package:logstf/repository/internal/settings_local_provider.dart';
import 'package:logstf/repository/external/logs_remote_provider.dart';
import 'package:logstf/repository/external/steam_remote_provider.dart';
import 'package:logstf/ui/about/page/about_page.dart';
import 'package:logstf/ui/help/page/help_page.dart';
import 'package:logstf/utils/routing_helper.dart';
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
  Dio provideDio() {
    Dio dio = Dio();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    return dio;
  }

  @provide
  @singleton
  AppDatabase provideAppDatabase() {
    return AppDatabase();
  }

  @provide
  @singleton
  RoutingHelper provideRoutingHelper(
      Sailor sailor,
      LogDetailsPageProvider logViewProvider,
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
  PlayersObservedLocalProvider providePlayersObservedLocalProvider(
      AppDatabase appDatabase) {
    return PlayersObservedLocalProvider(appDatabase);
  }

  @provide
  @singleton
  LogsRemoteProvider provideLogsRemoteProvider(Dio dio) {
    return LogsRemoteProvider(dio);
  }

  @provide
  @singleton
  LogsLocalProvider provideLogsLocalProvider(AppDatabase appDatabase) {
    return LogsLocalProvider(appDatabase);
  }

  @provide
  @singleton
  SteamRemoteProvider provideSteamRemoteProvider(Dio dio) {
    return SteamRemoteProvider(dio);
  }

  @provide
  @singleton
  SettingsLocalProvider provideSettingsLocalProvider() {
    return SettingsLocalProvider();
  }

  @provide
  @singleton
  PlayerRemoteRepositoryProvider provideLogsSearchPlayerProvider(Dio dio) {
    return PlayerRemoteRepositoryProvider(dio);
  }
}
