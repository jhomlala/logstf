import 'dart:convert';

import 'package:logstf/model/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalRepository {
  Future<AppSettings> getAppSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String appSettingsJson = prefs.getString("logs_tf_app_settings");
    if (appSettingsJson != null) {
      return AppSettings.fromJson(json.decode(appSettingsJson));
    } else {
      return null;
    }
  }

  void saveAppSettings(AppSettings appSettings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("logs_tf_app_settings", json.encode(appSettings.toJson()));
  }
}
