import 'package:flutter/material.dart';
import 'package:logstf/bloc/settings_bloc.dart';
import 'package:logstf/model/app_settings.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String _selectedColor = "Purple";
  Map<String, Color> _availableColors = Map();
  AppSettings _appSettings;

  @override
  void initState() {
    _availableColors["Purple"] = Colors.deepPurple;
    _availableColors["Orange"] = Colors.orange;
    _availableColors["Green"] = Colors.green;
    _availableColors["Blue"] = Colors.blue;
    _availableColors["Red"] = Colors.red;
    _availableColors["Pink"] = Colors.pink;
    super.initState();
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
                  appBar: AppBar( title: Text("Settings")), body: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(children: [
                            Text(
                              "App color: ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                            ),
                            _getDropdownButton()
                          ])),
                    )
                  ],
                ),
              ));
            });
  }

  Color _getColor() {
    return _availableColors[_selectedColor];
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
