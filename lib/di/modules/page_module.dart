import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
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
      AppStateManager appStateManager) {
    return MainPage(sailor, mainPageBlocProvider.create(), appStateManager);
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
      Sailor sailor, PlayerSearchResultsPageBlocProvider playerSearchResultsPageBlocProvider) {
    return PlayerSearchResultsPageProvider(sailor,playerSearchResultsPageBlocProvider.create());
  }
}
