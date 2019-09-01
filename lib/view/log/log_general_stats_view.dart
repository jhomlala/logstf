import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/bloc/log_details_bloc.dart';

import 'package:intl/intl.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/widget/teams_score_table_widget.dart';

class LogGeneralStatsView extends StatefulWidget {
  @override
  _LogGeneralStatsViewState createState() => _LogGeneralStatsViewState();
}

class _LogGeneralStatsViewState extends State<LogGeneralStatsView> {
  Log _log = logDetailsBloc.logSubject.value;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Column(children: [
          Container(
              margin: EdgeInsets.all(10),
              child: Card(
                  elevation: 10.0,
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    _getTitleWidget(context),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TeamsScoreTableWidget(
                      bluTeamScore: _log.teams.blue.score,
                      redTeamScore: _log.teams.red.score,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                  ]))),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Card(
                  elevation: 10.0,
                  child: Column(
                    children: [
                      _getMapWidget(context),
                      _getMatchTypeWidget(),
                      _getTimestampWidget(),
                      _getTimeWidget(context),
                      _getUploaderWidget()
                    ],
                  )))
        ]));
  }


  Widget _getTitleWidget(BuildContext context) {
    return Text(
      _log.info.title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.title,
    );
  }

  Widget _getMapWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            "assets/map.png",
            width: 20,
            height: 20,
          ),
          Text(" Map: "),
          Text(
            "${_log.info.map}",
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getTimeWidget(BuildContext context) {
    var length = _log.length;
    var lengthHours = (length / 3600).floor();
    var lengthMinutes = ((length - lengthHours * 3600) / 60).floor();
    var lengthSeconds = length - lengthHours * 3600 - lengthMinutes * 60;

    var lengthText = "";
    if (lengthHours > 0) {
      lengthText += "$lengthHours h";
    }
    if (lengthMinutes > 0) {
      lengthText += " $lengthMinutes m";
    }
    if (lengthSeconds > 0) {
      lengthText += " $lengthSeconds s";
    }
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            "assets/timer.png",
            width: 20,
            height: 20,
          ),
          Text("Played:"),
          Text(
            lengthText,
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getTimestampWidget() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(_log.info.date * 1000);
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            "assets/calendar.png",
            width: 20,
            height: 20,
          ),
          Text("Played at: "),
          Text(
            DateFormat('yyyy-MM-dd kk:mm:ss').format(dateTime),
            style: TextStyle(fontSize: 18),
          )
        ]));
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
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            "assets/battle.png",
            width: 20,
            height: 20,
          ),
          Text("Type: "),
          Text(
            matchType,
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getUploaderWidget() {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            "assets/upload.png",
            width: 20,
            height: 20,
          ),
          Text(" Uploaded by: "),
          Flexible(
              child: Container(
            child: Text(
                "${_log.info.uploader.name} (${_log.info.uploader.info})",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18)),
          ))
        ]));
  }
}
