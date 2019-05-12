



import 'package:flutter/widgets.dart';

import 'log_bloc.dart';

class LogBlocProvider extends InheritedWidget {
  final bloc = LogBloc();

  LogBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LogBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LogBlocProvider)
            as LogBlocProvider)
        .bloc;
  }
}
