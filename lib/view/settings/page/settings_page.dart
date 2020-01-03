import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_player_observed_bloc.dart';
import 'package:logstf/bloc/logs_saved_bloc.dart';
import 'package:logstf/bloc/players_observed_bloc.dart';
import 'package:logstf/view/common/page_provider.dart';
import 'package:logstf/view/settings/bloc/settings_bloc.dart';
import 'package:logstf/model/app_settings.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/util/application_localization.dart';
import 'package:logstf/view/common/base_page.dart';
import 'package:logstf/view/common/base_page_state.dart';
import 'package:logstf/widget/logs_button.dart';
import 'package:sailor/sailor.dart';

class SettingsPage extends BasePage {
  final SettingsBloc settingsBloc;

  SettingsPage(Sailor sailor, this.settingsBloc): super(sailor: sailor);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends BasePageState<SettingsPage> {
  SettingsBloc get _settingsBloc => widget.settingsBloc;
  String _selectedColor = "";
  String _selectedBrightness = "Light";
  Map<String, Color> _availableColors = Map();
  Map<String, Brightness> _availableBrightness = Map();
  AppSettings _appSettings;
  int _observedPlayersCount = 0;
  int _savedLogsCount = 0;
  StreamSubscription _playersObservedSubscription;
  StreamSubscription _savedLogsSubscription;

  @override
  void initState() {
    _playersObservedSubscription = playersObservedBloc.playersObservedSubject
        .listen((List<PlayerObserved> observedPlayers) {
      if (mounted) {
        setState(() {
          _observedPlayersCount = observedPlayers.length;
        });
      }
    });

    playersObservedBloc.getPlayersObserved();

    _savedLogsSubscription =
        logsSavedBloc.savedLogsSubject.listen((List<LogShort> logs) {
      if (mounted) {
        setState(() {
          _savedLogsCount = logs.length;
        });
      }
    });
    logsSavedBloc.getSavedLogs();

    super.initState();
  }

  @override
  void dispose() {
    _playersObservedSubscription.cancel();
    _savedLogsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
    _initColors(applicationLocalization);
    _initBrightnesses(applicationLocalization);

    return StreamBuilder(
        initialData: settingsBloc.appSettingsSubject.value,
        stream: settingsBloc.appSettingsSubject,
        builder: (context, snapshot) {
          _appSettings = snapshot.data;
          _setSelectedColor(_appSettings);
          _setSelectedBrightness(_appSettings);
          return Scaffold(
              appBar: AppBar(
                  elevation: 0.0,
                  title:
                      Text(applicationLocalization.getText("menu_settings"))),
              body: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(children: [
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  Text(
                                    "${applicationLocalization.getText("settings_app_color")} ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                  ),
                                  _getColorDropdownButton()
                                ]),
                            Divider(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  Text(
                                    "${applicationLocalization.getText("settings_app_brightness")} ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                  ),
                                  _getBrightnessDropdownButton()
                                ]),
                            Divider(),
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                              ),
                              Text(
                                  "${applicationLocalization.getText("settings_observed_players")} $_observedPlayersCount")
                            ]),
                            Row(children: [
                              LogsButton(
                                text: applicationLocalization
                                    .getText("settings_clear_observed_players"),
                                backgroundColor: Theme.of(context).primaryColor,
                                onPressed: () {
                                  _clearObservedPlayers();
                                },
                              )
                            ]),
                            Divider(),
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                              ),
                              Text(
                                  "${applicationLocalization.getText("settings_saved_matches")} $_savedLogsCount")
                            ]),
                            Row(children: [
                              LogsButton(
                                text: applicationLocalization
                                    .getText("settings_clear_saved_matches"),
                                backgroundColor: Theme.of(context).primaryColor,
                                onPressed: () {
                                  _clearSavedLogs();
                                },
                              )
                            ])
                          ])),
                    )
                  ])));
        });
  }

  void _clearObservedPlayers() {
    playersObservedBloc.deletePlayersObserved();
    logsPlayerObservedBloc.clearLogs();
  }

  void _clearSavedLogs() {
    logsSavedBloc.deleteSavedLogs();
  }

  Widget _getColorDropdownButton() {
    return DropdownButton<String>(
        elevation: 2,
        isDense: true,
        iconSize: 20.0,
        value: _selectedColor,
        items: _availableColors.keys.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value, style: TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (value) {
          String colorValue = _availableColors[value].value.toString();

          _appSettings.appColor = colorValue;
          settingsBloc.saveAppSettings(_appSettings);
          setState(() {
            _selectedColor = colorValue;
          });
        });
  }

  Widget _getBrightnessDropdownButton() {
    return DropdownButton<String>(
        elevation: 2,
        isDense: true,
        iconSize: 20.0,
        value: _selectedBrightness,
        items: _availableBrightness.keys.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value, style: TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (value) {
          Brightness brightness = _availableBrightness[value];
          _appSettings.appBrightness = brightness.index.toString();
          settingsBloc.saveAppSettings(_appSettings);
          setState(() {
            _selectedBrightness = value;
          });
        });
  }

  void _initColors(ApplicationLocalization applicationLocalization) {
    _availableColors[applicationLocalization.getText("settings_color_purple")] =
        Colors.deepPurple;
    _availableColors[applicationLocalization.getText("settings_color_orange")] =
        Colors.orange;
    _availableColors[applicationLocalization.getText("settings_color_green")] =
        Colors.green;
    _availableColors[applicationLocalization.getText("settings_color_blue")] =
        Colors.blue;
    _availableColors[applicationLocalization.getText("settings_color_red")] =
        Colors.red;
    _availableColors[applicationLocalization.getText("settings_color_pink")] =
        Colors.pink;
    _availableColors[applicationLocalization.getText("settings_color_black")] =
        Colors.black;
  }

  void _initBrightnesses(ApplicationLocalization applicationLocalization) {
    _availableBrightness[applicationLocalization
        .getText("settings_brightness_light")] = Brightness.light;
    _availableBrightness[applicationLocalization
        .getText("settings_brightness_dark")] = Brightness.dark;
  }

  void _setSelectedBrightness(AppSettings appSettings) {
    int selectedBrightnessIndex = int.parse(appSettings.appBrightness);
    _availableBrightness
        .forEach((String brightnessName, Brightness brightness) {
      if (selectedBrightnessIndex == brightness.index) {
        _selectedBrightness = brightnessName;
      }
    });
  }

  void _setSelectedColor(AppSettings appSettings) {
    String selectedColorValue = appSettings.appColor;
    _availableColors.forEach((String colorName, Color color) {
      if (selectedColorValue == color.value.toString()) {
        _selectedColor = colorName;
      }
    });
  }
}

class SettingsPageProvider extends PageProvider<SettingsPage>{
  final Sailor sailor;
  final SettingsBloc settingsBloc;
  SettingsPageProvider(this.sailor, this.settingsBloc);
  @override
  SettingsPage create() {
   return SettingsPage(sailor,settingsBloc);
  }

}