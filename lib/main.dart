import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/util/application_localization_delegate.dart';
import 'package:logstf/view/main_view.dart';
import 'bloc/logs_saved_bloc.dart';
import 'bloc/settings_bloc.dart';
import 'di/app_component.dart';
import 'di/modules/bloc_module.dart';
import 'di/modules/common_module.dart';
import 'di/modules/page_module.dart';
import 'model/app_settings.dart';

void main() async {
  var appComponent =
      await AppComponent.create(PageModule(), BlocModule(), CommonModule());
  runApp(appComponent.app);
}

@provide
class PocketLogsApp extends StatefulWidget {
  // This widget is the root of your application.
  final MainView mainView;

  const PocketLogsApp( this.mainView);

  @override
  State<StatefulWidget> createState() {
    return _PocketLogsAppState();
  }
}

class _PocketLogsAppState extends State<PocketLogsApp> {
  @override
  void initState() {
    super.initState();
    settingsBloc.getAppSettings();
    logsSavedBloc.initLogs();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: AppSettings(
            appColor: Colors.deepPurple.value.toString(), appBrightness: "0"),
        stream: settingsBloc.appSettingsSubject,
        builder: (context, snapshot) {
          return MaterialApp(
            key: Key("pocketLogsMaterialApp"),
            title: 'Pocket Logs',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                brightness: AppUtils.getBrightness(snapshot.data.appBrightness),
                primaryColor: Color(int.parse(snapshot.data.appColor))),
            home: widget.mainView,
            localizationsDelegates: [
              const ApplicationLocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale("en"),
              const Locale("pl"),
            ],
          );
        });
  }
}
