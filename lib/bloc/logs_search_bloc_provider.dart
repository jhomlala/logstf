import 'package:flutter/material.dart';

import 'logs_search_bloc.dart';

class LogsSearchBlocProvider extends InheritedWidget {
  final bloc = LogsSearchBloc();

  LogsSearchBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LogsSearchBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LogsSearchBlocProvider)
            as LogsSearchBlocProvider)
        .bloc;
  }
}
