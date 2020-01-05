import 'dart:async';
import 'package:logstf/model/internal/app_settings_changed_event.dart';
import 'package:logstf/repository/internal/settings_local_provider.dart';
import 'package:logstf/ui/common/base_bloc.dart';
import 'package:logstf/util/event_bus.dart';
import 'package:rxdart/rxdart.dart';

import 'model/internal/app_settings.dart';

class PocketLogsAppBloc extends BaseBloc {
  final SettingsLocalProvider settingsLocalProvider;
  final BehaviorSubject<AppSettings> appSettingsSubject = BehaviorSubject();

  PocketLogsAppBloc(this.settingsLocalProvider) {
    StreamSubscription appSettingsChangedEventSubscription =
        RxBus.register<AppSettingsChangedEvent>().listen((event) {
          appSettingsSubject.add(event.appSettings);
        });
    addSubscription(appSettingsChangedEventSubscription);
  }

  void getAppSettings() async {
    AppSettings appSettings = await settingsLocalProvider.getAppSettings();
    if (appSettings != null) {
      appSettingsSubject.add(appSettings);
    }
  }
}
