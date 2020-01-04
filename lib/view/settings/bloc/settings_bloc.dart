import 'package:flutter/material.dart';
import 'package:logstf/model/app_settings.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/local/settings_local_provider.dart';
import 'package:logstf/view/common/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  final BehaviorSubject<AppSettings> appSettingsSubject = BehaviorSubject();
  final PlayersObservedLocalProvider playersObservedLocalProvider;
  final LogsLocalProvider logsLocalProvider;
  final SettingsLocalProvider settingsLocalProvider;

  SettingsBloc(this.playersObservedLocalProvider, this.logsLocalProvider,
      this.settingsLocalProvider);

  void dispose() async {
    appSettingsSubject.close();
  }

  void getAppSettings() async {
    var appSettings = await settingsLocalProvider.getAppSettings();
    if (appSettings == null) {
      appSettings = AppSettings(
          appColor: Colors.deepPurple.value.toString(), appBrightness: "1");
    }
    appSettingsSubject.value = appSettings;
  }

  void saveAppSettings(AppSettings appSettings) {
    appSettingsSubject.value = appSettings;
    settingsLocalProvider.saveAppSettings(appSettings);
  }
}

SettingsBloc settingsBloc = null;

class SettingsBlocProvider extends BlocProvider<SettingsBloc> {
  final PlayersObservedLocalProvider playersObservedLocalProvider;
  final LogsLocalProvider logsLocalProvider;
  final SettingsLocalProvider settingsLocalProvider;

  SettingsBlocProvider(this.playersObservedLocalProvider,
      this.logsLocalProvider, this.settingsLocalProvider);

  @override
  SettingsBloc create() {
    return SettingsBloc(this.playersObservedLocalProvider,
        this.logsLocalProvider, this.settingsLocalProvider);
  }
}
