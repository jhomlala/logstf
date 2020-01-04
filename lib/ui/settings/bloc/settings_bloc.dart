import 'package:flutter/material.dart';
import 'package:logstf/model/internal/app_settings.dart';
import 'package:logstf/repository/local/logs_local_provider.dart';
import 'package:logstf/repository/local/players_observed_local_provider.dart';
import 'package:logstf/repository/local/settings_local_provider.dart';
import 'package:logstf/ui/common/bloc_provider.dart';
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

  Future<int> getPlayersObservedCount() async {
    return playersObservedLocalProvider.getPlayersObservedCount();
  }

  Future<int> getSavedLogsCount() async {
    return logsLocalProvider.getLogsCount();
  }

  Future deleteSavedLogs() async {
    return logsLocalProvider.deleteLogs();
  }

  Future deleteSavedPlayers() async {
    return playersObservedLocalProvider.deletePlayersObserved();
  }
}

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
