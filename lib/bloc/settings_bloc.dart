import 'package:logstf/model/app_settings.dart';
import 'package:logstf/repository/local/settings_local_provider.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  BehaviorSubject<AppSettings> appSettingsSubject = BehaviorSubject();

  dispose() async {
    await appSettingsSubject.drain();
    appSettingsSubject.close();
  }

  getAppSettings() async {
    var appSettings = await settingsLocalProvider.getAppSettings();
    appSettingsSubject.value = appSettings;
  }

  saveAppSettings(AppSettings appSettings) {
    settingsLocalProvider.saveAppSettings(appSettings);
  }
}

final settingsBloc = SettingsBloc();
