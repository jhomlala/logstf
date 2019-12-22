import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:logstf/view/logs/logs_list_view.dart';
import 'package:logstf/view/main_view.dart';
import 'package:sailor/sailor.dart';

@module
class PageModule {
  @provide
  MainView provideMainPage(LogsListView logsListView) {
    return MainView(logsListView);
  }

  @provide
  LogsListView provideLogsListPage(
      LogsSearchBlocProvider logsSearchBlocProvider, Sailor sailor) {
    return LogsListView(logsSearchBlocProvider.create(), sailor);
  }

  @provide
  LogViewProvider provideLogViewProvider(
      LogDetailsBlocProvider logDetailsBlocProvider) {
    return LogViewProvider(logDetailsBlocProvider.create());
  }
}
