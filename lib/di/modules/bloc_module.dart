import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/bloc/logs_search_bloc.dart';
import 'package:logstf/bloc/player_search_bloc.dart';

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
  LogsSearchBlocProvider provideLogsSearchBlocProvider(){
    return LogsSearchBlocProvider();
  }
}
