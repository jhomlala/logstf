import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/view/main/main_page_bloc.dart';
import 'package:logstf/bloc/player_search_bloc.dart';
import 'package:logstf/view/search/search_page_bloc.dart';

@module
class BlocModule {
  @provide
  LogDetailsBlocProvider provideLogDetailsBlocProvider() {
    return LogDetailsBlocProvider();
  }

  @provide
  PlayerSearchBlocProvider provideSearchPlayerBlocProvider() {
    return PlayerSearchBlocProvider();
  }

  @provide
  MainPageBlocProvider provideLogsSearchBlocProvider(){
    return MainPageBlocProvider();
  }

  @provide
  SearchPageBlocProvider provideSearchPageBlocProvider(){
    return SearchPageBlocProvider();
  }
}
