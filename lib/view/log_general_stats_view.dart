import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/bloc/log_bloc.dart';
import 'package:logstf/bloc/log_bloc_provider.dart';

import 'package:intl/intl.dart';
import 'package:logstf/model/log.dart';

class LogGeneralStatsView extends StatefulWidget {


  @override
  _LogGeneralStatsViewState createState() => _LogGeneralStatsViewState();
}

class _LogGeneralStatsViewState extends State<LogGeneralStatsView> {
  LogBloc _bloc;
  Log _log;

  @override
  Widget build(BuildContext context) {
    _bloc = LogBlocProvider.of(context);
    _log = _bloc.logSubject.value;

    return Container(
        child: Column(children: [
      _getOverallResultWidget(),
      Padding(padding: EdgeInsets.only(top: 20)),
      _getTitleWidget(context),
      Padding(padding: EdgeInsets.only(top: 10)),
      _getMapWidget(context),
      Padding(padding: EdgeInsets.only(top: 10)),
      _getMatchTypeWidget(),
      Padding(padding: EdgeInsets.only(top: 10)),
      _getTimestampWidget(),
      Padding(padding: EdgeInsets.only(top: 10)),
      _getTimeWidget(context),
      Padding(padding: EdgeInsets.only(top: 10)),
      _getUploaderWidget()
    ]));
  }

  Widget _getOverallResultWidget() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          height: 100,
          decoration: BoxDecoration(color: Colors.blue),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text("BLU", style: TextStyle(fontSize: 30, color: Colors.white)),
            Text("${getRoundsWonByTeam("Blue")}",
                style: TextStyle(fontSize: 30, color: Colors.white))
          ]),
        )),
        Expanded(
            child: Container(
          height: 100,
          decoration: BoxDecoration(color: Colors.red),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text("RED", style: TextStyle(fontSize: 30, color: Colors.white)),
            Text("${getRoundsWonByTeam("Red")}",
                style: TextStyle(fontSize: 30, color: Colors.white))
          ]),
        )),
      ],
    );
  }

  int getRoundsWonByTeam(String team) {
    return _log.rounds.where((round) => round.winner == team).length;
  }

  Widget _getTitleWidget(BuildContext context) {
    return Text(_log.info.title,
        style: Theme.of(context).textTheme.title);
  }

  Widget _getMapWidget(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        "assets/map.png",
        width: 20,
        height: 20,
      ),
      Text(
        " ${_log.info.map}",
        style: TextStyle(fontSize: 16),
      )
    ]);
  }

  Widget _getTimeWidget(BuildContext context) {
    var length = _log.length;
    var lengthHours = (length / 3600).floor();
    var lengthMinutes = ((length - lengthHours * 3600) / 60).floor();
    var lengthSeconds = length - lengthHours * 3600 - lengthMinutes * 60;
    print("length hours: " +
        lengthHours.toString() +
        " length minutes: " +
        lengthMinutes.toString() +
        " lengthSeconds: " +
        lengthSeconds.toString());
    var lengthText = "";
    if (lengthHours > 0) {
      lengthText += "$lengthHours m";
    }
    if (lengthMinutes > 0) {
      lengthText += " $lengthMinutes m";
    }
    if (lengthSeconds > 0) {
      lengthText += " $lengthSeconds s";
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        "assets/timer.png",
        width: 20,
        height: 20,
      ),
      Text(
        lengthText,
        style: TextStyle(fontSize: 16),
      )
    ]);
  }

  Widget _getTimestampWidget() {
    var dateTime =
        DateTime.fromMillisecondsSinceEpoch(_log.info.date * 1000);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        "assets/calendar.png",
        width: 20,
        height: 20,
      ),
      Text(
        DateFormat('yyyy-MM-dd kk:mm:ss').format(dateTime),
        style: TextStyle(fontSize: 16),
      )
    ]);
  }

  Widget _getMatchTypeWidget() {
    var matchType = "???";
    var playersCount = _log.players.length;
    print("Players: " + playersCount.toString());
    if (playersCount >= 12 && playersCount < 18) {
      matchType = "6v6";
    } else if (playersCount >= 18) {
      matchType = "Highlander";
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        "assets/battle.png",
        width: 20,
        height: 20,
      ),
      Text(
        matchType,
        style: TextStyle(fontSize: 16),
      )
    ]);
  }

  Widget _getUploaderWidget() {
    return Text(
      "Uploaded by: ${_log.info.uploader.name} (${_log.info.uploader.info})",
      style: TextStyle(fontSize: 16),
    );
  }
}
