import 'package:flutter/material.dart';
import 'package:logstf/model/app_settings.dart';
import 'package:logstf/repository/local/settings_local_provider.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  final BehaviorSubject<AppSettings> appSettingsSubject = BehaviorSubject();

  void dispose() async {
    appSettingsSubject.close();
  }

  void getAppSettings() async {
    var appSettings = await settingsLocalProvider.getAppSettings();
    if (appSettings == null){
      appSettings = AppSettings(appColor:Colors.deepPurple.value.toString(), appBrightness: "1");
    }
    appSettingsSubject.value = appSettings;
  }

  void saveAppSettings(AppSettings appSettings) {
    appSettingsSubject.value = appSettings;
    settingsLocalProvider.saveAppSettings(appSettings);
  }
}

final SettingsBloc settingsBloc = SettingsBloc();
