import 'package:logstf/model/internal/app_settings.dart';
import 'package:logstf/repository/local/settings_local_repository.dart';

class SettingsLocalProvider {
  SettingsLocalRepository _settingsLocalRepository = SettingsLocalRepository();

  Future<AppSettings> getAppSettings() {
    return _settingsLocalRepository.getAppSettings();
  }

  void saveAppSettings(AppSettings appSettings) {
    _settingsLocalRepository.saveAppSettings(appSettings);
  }
}

final SettingsLocalProvider settingsLocalProvider = SettingsLocalProvider();
