import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/bloc/log_details_bloc.dart';

import 'package:intl/intl.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/match_type.dart';
import 'package:logstf/util/app_utils.dart';
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
        child: SingleChildScrollView(
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
                    Padding(padding: EdgeInsets.only(top: 10)),
                  ]))),
          Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                      elevation: 10.0,
                      child: Container(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Table(
                            children: _getTeamStatsTableRows(),
                          ))))),
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
                      _getUploaderWidget(),
                      _getMatchIdWidget()
                    ],
                  ))),
        ])));
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
          Image.asset("assets/map.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  Map: "),
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
          Image.asset("assets/timer.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  Played:"),
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
          Image.asset("assets/calendar.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  Played at: "),
          Text(
            DateFormat('yyyy-MM-dd kk:mm:ss').format(dateTime),
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getMatchTypeWidget() {
    MatchType matchType =
        LogHelper.getMatchType(_log.players.values.length, _log.info.map);
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset("assets/battle.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  Type: "),
          Text(
            matchType.name,
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget _getUploaderWidget() {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset("assets/upload.png",
              width: 20, height: 20, color: AppUtils.getIconColor(context)),
          Text("  Uploaded by: "),
          Flexible(
              child: Container(
            child: Text(
                "${_log.info.uploader.name} (${_log.info.uploader.info})",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18)),
          ))
        ]));
  }

  Widget _getMatchIdWidget() {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(
            Icons.important_devices,
            color: AppUtils.getIconColor(context),
            size: 20,
          ),
          Text("  Match id: "),
          Flexible(
              child: Container(
            child: Text("#${_log.id}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18)),
          ))
        ]));
  }

  List<TableRow> _getTeamStatsTableRows() {
    List<TableRow> tableRows = List();
    tableRows.add(_getHeaderRow());
    tableRows.add(_getRow("Kills", "${LogHelper.getKillsSum(_log, "Red")}",
        "${LogHelper.getKillsSum(_log, "Blue")}"));
    tableRows.add(_getRow("Deaths", "${LogHelper.getDeathsSum(_log, "Red")}",
        "${LogHelper.getDeathsSum(_log, "Blue")}"));
    tableRows.add(_getRow("Assists", "${LogHelper.getAssistsSum(_log, "Red")}",
        "${LogHelper.getAssistsSum(_log, "Blue")}"));
    tableRows.add(_getRow("Damage", "${LogHelper.getDamageSum(_log, "Red")}",
        "${LogHelper.getDamageSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        "Damage Taken",
        "${LogHelper.getDamageTakenSum(_log, "Red")}",
        "${LogHelper.getDamageTakenSum(_log, "Blue")}"));
    tableRows.add(_getRow("Caps", "${LogHelper.getCapSum(_log, "Red")}",
        "${LogHelper.getCapSum(_log, "Blue")}"));
    tableRows.add(_getRow("Charges", "${LogHelper.getChargeSum(_log, "Red")}",
        "${LogHelper.getChargeSum(_log, "Blue")}"));
    tableRows.add(_getRow("Drops", "${LogHelper.getDropSum(_log, "Red")}",
        "${LogHelper.getDropSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        "KA/D",
        "${LogHelper.getTeamKAPD(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamKAPD(_log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "D/M",
        "${LogHelper.getTeamDamagePerMinute(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamDamagePerMinute(_log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "K/D",
        "${LogHelper.getTeamKillsPerDeaths(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamKillsPerDeaths(_log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "DT/M",
        "${LogHelper.getTeamDamageTakenPerMinute(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamDamageTakenPerMinute(_log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "HP pickups",
        "${LogHelper.getMedkitsSum(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getMedkitsSum(_log, "Blue").toStringAsFixed(2)}"));

    tableRows.add(_getRow(
        "HP from pickups",
        "${LogHelper.getMedkitsHPSum(_log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getMedkitsHPSum(_log, "Blue").toStringAsFixed(0)}"));

    tableRows.add(_getRow(
        "Headshots",
        "${LogHelper.getHeadshotsSum(_log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getHeadshotsSum(_log, "Blue").toStringAsFixed(0)}"));

    tableRows.add(_getRow(
        "Sentries",
        "${LogHelper.getSentriesSum(_log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getSentriesSum(_log, "Blue").toStringAsFixed(0)}"));

    tableRows.add(_getRow(
        "Backstabs",
        "${LogHelper.getBackstabsSum(_log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getBackstabsSum(_log, "Blue").toStringAsFixed(0)}"));
    return tableRows;
  }

  TableRow _getHeaderRow() {
    return TableRow(children: [
      Container(
          color: Theme.of(context).primaryColor,
          child: Container(
              decoration: BoxDecoration(
                  color: AppUtils.darkBlueColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
              height: 30,
              child: Center(
                  child: Text("METRIC",
                      style: TextStyle(color: Colors.white, fontSize: 16))))),
      Container(
          decoration: BoxDecoration(color: Colors.red),
          height: 30,
          child: Center(
              child: Text("RED",
                  style: TextStyle(color: Colors.white, fontSize: 16)))),
      Container(
          color: Theme.of(context).primaryColor,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(8))),
              height: 30,
              child: Center(
                  child: Text("BLU",
                      style: TextStyle(color: Colors.white, fontSize: 16)))))
    ]);
  }

  TableRow _getRow(
      String metricName, String redTeamValue, String blueTeamValue) {
    return TableRow(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppUtils.getBorderColor(context)))),
        children: [
          Container(
              height: 20,
              child: Center(
                  child: Text(
                metricName,
                style: TextStyle(fontSize: 16),
              ))),
          Container(
              height: 20,
              child: Center(
                  child: Text(redTeamValue, style: TextStyle(fontSize: 16)))),
          Container(
              height: 20,
              child: Center(
                  child: Text(blueTeamValue, style: TextStyle(fontSize: 16))))
        ]);
  }
}
