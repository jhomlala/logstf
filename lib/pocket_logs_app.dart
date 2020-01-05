import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:logstf/pocket_logs_app_bloc.dart';
import 'package:logstf/repository/internal/settings_local_provider.dart';
import 'package:logstf/utils/app_utils.dart';
import 'package:logstf/utils/application_localization_delegate.dart';
import 'package:logstf/utils/routing_helper.dart';
import 'package:logstf/ui/main/page/main_page.dart';
import 'package:sailor/sailor.dart';
import 'model/internal/app_settings.dart';

@provide
class PocketLogsApp extends StatefulWidget {
  final MainPageProvider mainPageProvider;
  final Sailor sailor;
  final RoutingHelper routingHelper;
  final SettingsLocalProvider settingsLocalProvider;

  const PocketLogsApp(this.mainPageProvider, this.sailor, this.routingHelper,
      this.settingsLocalProvider);

  @override
  State<StatefulWidget> createState() {
    return _PocketLogsAppState();
  }
}

class _PocketLogsAppState extends State<PocketLogsApp> {
  PocketLogsAppBloc pocketLogsAppBloc;

  @override
  void initState() {
    super.initState();
    widget.routingHelper.setupRoutes();
    pocketLogsAppBloc = PocketLogsAppBloc(widget.settingsLocalProvider);
    pocketLogsAppBloc.getAppSettings();
    Fimber.d("App init completed");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: AppSettings(
            appColor: Colors.deepPurple.value.toString(), appBrightness: "0"),
        stream: pocketLogsAppBloc.appSettingsSubject,
        builder: (context, snapshot) {
          return MaterialApp(
            key: Key("pocketLogsMaterialApp"),
            title: 'Pocket Logs',
            navigatorKey: widget.sailor.navigatorKey,
            onGenerateRoute: widget.sailor.generator(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                brightness: AppUtils.getBrightness(snapshot.data.appBrightness),
                primaryColor: Color(int.parse(snapshot.data.appColor))),
            home: widget.mainPageProvider.create(),
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
