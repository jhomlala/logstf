import 'package:logstf/model/app_settings.dart';
import 'package:logstf/repository/local/settings_local_repository.dart';

class SettingsLocalProvider{
  SettingsLocalRepository repository = SettingsLocalRepository();

  Future<AppSettings> getAppSettings() {
    return repository.getAppSettings();
  }

  void saveAppSettings(AppSettings appSettings){
    repository.saveAppSettings(appSettings);
  }

}

final SettingsLocalProvider settingsLocalProvider = SettingsLocalProvider();