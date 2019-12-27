import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
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
      providePlayerSearchResultsPageBlocProvider() {
    return PlayerSearchResultsPageBlocProvider();
  }
}
