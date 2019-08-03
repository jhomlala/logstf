import 'package:flutter/material.dart';
import 'package:logstf/view/main_view.dart';

import 'bloc/logs_saved_bloc.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    logsSavedBloc.initLogs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Logs TF',
        theme: ThemeData(primaryColor: Colors.deepPurple),
        home: MainView());
  }
}
