import 'package:flutter/material.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/view/main_view.dart';

import 'bloc/logs_saved_bloc.dart';
import 'bloc/settings_bloc.dart';
import 'model/app_settings.dart';

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
    settingsBloc.getAppSettings();
    logsSavedBloc.initLogs();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: AppSettings(appColor: "Purple"),
        stream: settingsBloc.appSettingsSubject,
        builder: (context, snapshot) {
          return MaterialApp(
              title: 'Logs TF',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primaryColor: AppUtils.getColor(snapshot.data.appColor)),
              home: MainView());
        });
  }
}
