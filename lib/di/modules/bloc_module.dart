import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/view/main/bloc/main_page_bloc.dart';
import 'package:logstf/view/search/bloc/player_search_results_page_bloc.dart';
import 'package:logstf/view/search/bloc/search_page_bloc.dart';

@module
class BlocModule {
  @provide
  LogDetailsBlocProvider provideLogDetailsBlocProvider() {
    return LogDetailsBlocProvider();
  }

  @provide
  MainPageBlocProvider provideLogsSearchBlocProvider() {
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
}
