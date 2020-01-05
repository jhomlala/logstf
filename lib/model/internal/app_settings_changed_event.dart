import 'package:logstf/model/internal/app_settings.dart';

class AppSettingsChangedEvent{
  final AppSettings appSettings;

  AppSettingsChangedEvent(this.appSettings);
}