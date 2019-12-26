import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/repository/local/app_state_manager.dart';
import 'package:logstf/view/main/main_page_bloc.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:logstf/view/search/search_page.dart';
import 'package:logstf/view/main/main_page.dart';
import 'package:logstf/view/search/search_page_bloc.dart';
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
  SearchPageProvider provideSearchPageProvider(Sailor sailor, SearchPageBlocProvider searchPageBlocProvider) {
    return SearchPageProvider(sailor,searchPageBlocProvider.create());
  }
}