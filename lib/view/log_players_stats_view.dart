import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';

class LogPlayersStatsView extends StatefulWidget {

  final Log log;

  const LogPlayersStatsView({Key key, this.log}) : super(key: key);

  @override
  _LogPlayersStatsViewState createState() => _LogPlayersStatsViewState();
}

class _LogPlayersStatsViewState extends State<LogPlayersStatsView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [_getPlayersDropdown()]));
  }

  Widget _getPlayersDropdown() {
    var playerNames = LogHelper.getPlayerNames(widget.log);
    print("Player names: " + playerNames.toString());

    return DropdownButton<String>(
        value: playerNames[0],
        style: TextStyle(color: Colors.black),
        items:playerNames.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {});
        });
  }
}
