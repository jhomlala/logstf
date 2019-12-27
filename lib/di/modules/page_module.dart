import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/view/main/bloc/logs_list_fragment_bloc.dart';
import 'package:logstf/view/main/bloc/logs_saved_logs_fragment_bloc.dart';
import 'package:logstf/view/main/bloc/logs_saved_players_fragment_bloc.dart';
import 'package:logstf/view/main/bloc/main_page_bloc.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:logstf/view/search/bloc/player_search_results_page_bloc.dart';
import 'package:logstf/view/search/page/player_search_results_page.dart';
import 'package:logstf/view/search/page/search_page.dart';
import 'package:logstf/view/main/page/main_page.dart';
import 'package:logstf/view/search/bloc/search_page_bloc.dart';
import 'package:sailor/sailor.dart';

@module
class PageModule {
  @provide
  MainPage provideMainPage(
      Sailor sailor,
      MainPageBlocProvider mainPageBlocProvider,
      AppStateManager appStateManager,
      LogsListFragmentBlocProvider logsListFragmentBlocProvider,
      LogsSavedPlayersFragmentBlocProvider logsSavedPlayersFragmentBlocProvider,
      LogsSavedLogsFragmentBlocProvider logsSavedLogsFragmentBlocProvider) {
    return MainPage(
        sailor,
        mainPageBlocProvider.create(),
        appStateManager,
        logsListFragmentBlocProvider.create(),
        logsSavedPlayersFragmentBlocProvider.create(),
        logsSavedLogsFragmentBlocProvider.create());
  }

  @provide
  LogViewProvider provideLogViewProvider(
      LogDetailsBlocProvider logDetailsBlocProvider) {
    return LogViewProvider(logDetailsBlocProvider.create());
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
}
