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
  Map<String, Color> _availableColors = Map();
  AppSettings _appSettings;
  int observedPlayersCount = 0;
  int savedLogsCount = 0;
  StreamSubscription playersObservedSubscription;
  StreamSubscription savedLogsSubscription;

  @override
  void initState() {
    _availableColors["Purple"] = Colors.deepPurple;
    _availableColors["Orange"] = Colors.orange;
    _availableColors["Green"] = Colors.green;
    _availableColors["Blue"] = Colors.blue;
    _availableColors["Red"] = Colors.red;
    _availableColors["Pink"] = Colors.pink;

    playersObservedSubscription = playersObservedBloc.playersObservedSubject
        .listen((List<PlayerObserved> observedPlayers) {
      setState(() {
        observedPlayersCount = observedPlayers.length;
      });
    });

    playersObservedBloc.getPlayersObserved();

    savedLogsSubscription =
        logsSavedBloc.savedLogsSubject.listen((List<LogShort> logs) {
      setState(() {
        savedLogsCount = logs.length;
      });
    });
    logsSavedBloc.getSavedLogs();

    super.initState();
  }

  @override
  void dispose() {
    playersObservedSubscription.cancel();
    savedLogsSubscription.cancel();
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
                                  _getDropdownButton()
                                ]),
                            Divider(),
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                              ),
                              Text("Observed players: $observedPlayersCount")
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
                              Text("Saved matches: $savedLogsCount")
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

  Widget _getDropdownButton() {
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
}
