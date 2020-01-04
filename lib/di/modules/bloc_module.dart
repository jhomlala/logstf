import 'package:inject/inject.dart';
import 'package:logstf/repository/external/player_remote_repository_provider.dart';
import 'package:logstf/repository/internal/settings_local_provider.dart';
import 'package:logstf/repository/external/steam_remote_provider.dart';
import 'package:logstf/ui/log/bloc/log_details_bloc.dart';
import 'package:logstf/repository/internal/app_state_manager.dart';
import 'package:logstf/repository/internal/logs_local_provider.dart';
import 'package:logstf/repository/internal/players_observed_local_provider.dart';
import 'package:logstf/repository/external/logs_remote_provider.dart';
import 'package:logstf/ui/main/bloc/logs_list_fragment_bloc.dart';
import 'package:logstf/ui/main/bloc/logs_saved_logs_fragment_bloc.dart';
import 'package:logstf/ui/main/bloc/logs_saved_players_fragment_bloc.dart';
import 'package:logstf/ui/main/bloc/main_page_bloc.dart';
import 'package:logstf/ui/player/bloc/log_player_player_fragment_bloc.dart';
import 'package:logstf/ui/search/bloc/player_search_results_page_bloc.dart';
import 'package:logstf/ui/search/bloc/search_page_bloc.dart';
import 'package:logstf/ui/settings/bloc/settings_bloc.dart';

@module
class BlocModule {
  @provide
  LogDetailsBlocProvider provideLogDetailsBlocProvider(LogsRemoteProvider logsRemoteProvider, LogsLocalProvider logsLocalProvider) {
    return LogDetailsBlocProvider(logsRemoteProvider, logsLocalProvider);
  }

  @provide
  MainPageBlocProvider provideMainPageBlocProvider() {
    return MainPageBlocProvider();
  }

  @provide
  SearchPageBlocProvider provideSearchPageBlocProvider() {
    return SearchPageBlocProvider();
  }

  @provide
  PlayerSearchResultsPageBlocProvider
      providePlayerSearchResultsPageBlocProvider(
          AppStateManager appStateManager,
          PlayersObservedLocalProvider playersObservedLocalProvider,
          PlayerRemoteRepositoryProvider logsSearchPlayerProvider) {
    return PlayerSearchResultsPageBlocProvider(appStateManager,
        playersObservedLocalProvider, logsSearchPlayerProvider);
  }

  @provide
  LogsSavedPlayersFragmentBlocProvider
      provideLogsSavedPlayersFragmentBlocProvider(
          LogsRemoteProvider logsRemoteProvider,
          PlayersObservedLocalProvider playersObservedLocalProvider) {
    return LogsSavedPlayersFragmentBlocProvider(
        logsRemoteProvider, playersObservedLocalProvider);
  }

  @provide
  LogsSavedLogsFragmentBlocProvider provideLogsSavedLogsFragmentBlocProvider(
      LogsLocalProvider logsLocalProvider) {
    return LogsSavedLogsFragmentBlocProvider(logsLocalProvider);
  }

  @provide
  LogsListFragmentBlocProvider provideLogsListFragmentBlocProvider(
      LogsRemoteProvider logsRemoteProvider) {
    return LogsListFragmentBlocProvider(logsRemoteProvider);
  }

  @provide
  LogPlayerPlayerFragmentBlocProvider
      provideLogPlayerPlayerFragmentBlocProvider(
          LogsRemoteProvider logsRemoteProvider,
          SteamRemoteProvider steamRemoteProvider,
          PlayersObservedLocalProvider playersObservedLocalProvider) {
    return LogPlayerPlayerFragmentBlocProvider(
        logsRemoteProvider, steamRemoteProvider, playersObservedLocalProvider);
  }

  @provide
  SettingsBlocProvider provideSettingsBlocProvider(
    PlayersObservedLocalProvider playersObservedLocalProvider,
    LogsLocalProvider logsLocalProvider,
    SettingsLocalProvider settingsLocalProvider,
  ) {
    return SettingsBlocProvider(
        playersObservedLocalProvider, logsLocalProvider, settingsLocalProvider);
  }
}
