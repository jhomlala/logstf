import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logstf/bloc/logs_player_observed_bloc.dart';
import 'package:logstf/bloc/logs_saved_bloc.dart';
import 'package:logstf/bloc/players_observed_bloc.dart';
import 'package:logstf/bloc/settings_bloc.dart';
import 'package:logstf/model/app_settings.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player_observed.dart';
import 'package:logstf/widget/logs_button.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String _selectedColor = "Purple";
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
    _availableColors["Purple"] = Colors.deepPurple;
    _availableColors["Orange"] = Colors.orange;
    _availableColors["Green"] = Colors.green;
    _availableColors["Blue"] = Colors.blue;
    _availableColors["Red"] = Colors.red;
    _availableColors["Pink"] = Colors.pink;
    _availableColors["Black"] = Colors.black;

    _availableBrightness["Light"] = Brightness.light;
    _availableBrightness["Dark"] = Brightness.dark;

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
    return StreamBuilder(
        initialData: settingsBloc.appSettingsSubject.value,
        stream: settingsBloc.appSettingsSubject,
        builder: (context, snapshot) {
          _appSettings = snapshot.data;
          _selectedColor = _appSettings.appColor;
          print("Selected app color: " + _appSettings.appColor);
          _selectedBrightness = _appSettings.appBrightness;
          return Scaffold(
              appBar: AppBar(elevation: 0.0, title: Text("Settings")),
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
                                    "App color: ",
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
                                        "App brightness: ",
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
                              Text("Observed players: $_observedPlayersCount")
                            ]),
                            Row(children: [
                              LogsButton(
                                text: "Clear observed players",
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
                              Text("Saved matches: $_savedLogsCount")
                            ]),
                            Row(children: [
                              LogsButton(
                                text: "Clear saved matches",
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
          _appSettings.appColor = value;
          settingsBloc.saveAppSettings(_appSettings);
          setState(() {
            _selectedColor = value;
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
          _appSettings.appBrightness = value;
          settingsBloc.saveAppSettings(_appSettings);
          setState(() {
            _selectedBrightness = value;
          });
        });
  }
}
