import 'package:inject/inject.dart';
import 'package:logstf/view/log/bloc/log_details_bloc.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/view/main/bloc/logs_list_fragment_bloc.dart';
import 'package:logstf/view/main/bloc/logs_saved_logs_fragment_bloc.dart';
import 'package:logstf/view/main/bloc/logs_saved_players_fragment_bloc.dart';
import 'package:logstf/view/log/page/log_page.dart';
import 'package:logstf/view/player/bloc/log_player_player_fragment_bloc.dart';
import 'package:logstf/view/player/page/log_player_page.dart';
import 'package:logstf/view/search/bloc/player_search_results_page_bloc.dart';
import 'package:logstf/view/search/page/player_search_results_page.dart';
import 'package:logstf/view/search/page/search_page.dart';
import 'package:logstf/view/main/page/main_page.dart';
import 'package:logstf/view/search/bloc/search_page_bloc.dart';
import 'package:logstf/view/settings/bloc/settings_bloc.dart';
import 'package:logstf/view/settings/page/settings_page.dart';
import 'package:sailor/sailor.dart';

@module
class PageModule {
  @provide
  MainPage provideMainPage(
      Sailor sailor,
      AppStateManager appStateManager,
      LogsListFragmentBlocProvider logsListFragmentBlocProvider,
      LogsSavedPlayersFragmentBlocProvider logsSavedPlayersFragmentBlocProvider,
      LogsSavedLogsFragmentBlocProvider logsSavedLogsFragmentBlocProvider) {
    return MainPage(
        sailor,
        appStateManager,
        logsListFragmentBlocProvider.create(),
        logsSavedPlayersFragmentBlocProvider.create(),
        logsSavedLogsFragmentBlocProvider.create());
  }

  @provide
  LogViewProvider provideLogViewProvider(
      Sailor sailor, LogDetailsBlocProvider logDetailsBlocProvider) {
    return LogViewProvider(sailor, logDetailsBlocProvider.create());
  }

  @provide
  SearchPageProvider provideSearchPageProvider(
      Sailor sailor, SearchPageBlocProvider searchPageBlocProvider) {
    return SearchPageProvider(sailor, searchPageBlocProvider.create());
  }

  @provide
  PlayerSearchResultsPageProvider providePlayerSearchResultsPageProvider(
      Sailor sailor,
      PlayerSearchResultsPageBlocProvider playerSearchResultsPageBlocProvider) {
    return PlayerSearchResultsPageProvider(
        sailor, playerSearchResultsPageBlocProvider.create());
  }

  @provide
  LogPlayerPageProvider provideLogPlayerPageProvider(Sailor sailor,
      LogPlayerPlayerFragmentBlocProvider logPlayerPlayerFragmentBlocProvider) {
    return LogPlayerPageProvider(sailor,logPlayerPlayerFragmentBlocProvider.create());
  }

  @provide
  SettingsPageProvider provideSettingsPage(Sailor sailor, SettingsBlocProvider settingsBlocProvider){
    return SettingsPageProvider(sailor, settingsBlocProvider.create());
  }
}
