import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/view/log/log_view.dart';
import 'package:logstf/view/logs/logs_list_view.dart';
import 'package:logstf/view/main_view.dart';

import 'bloc_module.dart';

@module
class PageModule {
  @provide
  MainView provideMainPage(LogView logView) {
    return MainView(
      logView: logView,
    );
  }

  @provide
  LogsListView provideLogsListPage() {
    return LogsListView();
  }

  @provide
  LogView provideLogPage(Provider<LogDetailsBloc> logDetailsBloc) {
    return LogView(logDetailsBloc: logDetailsBloc.create());
  }
}
