import 'dart:convert';

import 'package:logstf/model/internal/app_settings.dart';
import 'package:logstf/utils/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalRepository {
  Future<AppSettings> getAppSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String appSettingsJson = prefs.getString(AppConst.settingsKey);
    if (appSettingsJson != null) {
      return AppSettings.fromJson(json.decode(appSettingsJson));
    } else {
      return null;
    }
  }

  void saveAppSettings(AppSettings appSettings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConst.settingsKey, json.encode(appSettings.toJson()));
  }
}
