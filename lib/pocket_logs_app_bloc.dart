import 'package:logstf/repository/local/settings_local_provider.dart';
import 'package:logstf/ui/common/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'model/internal/app_settings.dart';

class PocketLogsAppBloc extends BaseBloc{
  final SettingsLocalProvider settingsLocalProvider;
  final BehaviorSubject<AppSettings> appSettingsSubject = new BehaviorSubject();

  PocketLogsAppBloc(this.settingsLocalProvider);

  void getAppSettings() async{
    AppSettings appSettings = await settingsLocalProvider.getAppSettings();
    appSettingsSubject.add(appSettings);
  }

}