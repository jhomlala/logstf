import 'package:inject/inject.dart';
import 'package:logstf/repository/local/settings_local_provider.dart';
import 'package:logstf/repository/remote/steam_remote_provider.dart';
import 'package:logstf/view/log/bloc/log_details_bloc.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/remote/logs_remote_provider.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:logstf/view/main/bloc/logs_list_fragment_bloc.dart';
import 'package:logstf/view/main/bloc/logs_saved_logs_fragment_bloc.dart';
import 'package:logstf/view/main/bloc/logs_saved_players_fragment_bloc.dart';
import 'package:logstf/view/main/bloc/main_page_bloc.dart';
import 'package:logstf/view/player/bloc/log_player_player_fragment_bloc.dart';
import 'package:logstf/view/search/bloc/player_search_results_page_bloc.dart';
import 'package:logstf/view/search/bloc/search_page_bloc.dart';
import 'package:logstf/view/settings/bloc/settings_bloc.dart';

@module
class BlocModule {
  @provide
  LogDetailsBlocProvider provideLogDetailsBlocProvider() {
    return LogDetailsBlocProvider();
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
          PlayersObservedLocalProvider playersObservedLocalProvider) {
    return PlayerSearchResultsPageBlocProvider(
        appStateManager, playersObservedLocalProvider);
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
