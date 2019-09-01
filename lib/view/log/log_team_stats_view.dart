import 'package:flutter/material.dart';
import 'package:logstf/bloc/log_details_bloc.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/util/app_utils.dart';

class LogTeamStatsView extends StatefulWidget {

  @override
  _LogTeamStatsViewState createState() => _LogTeamStatsViewState();
}

class _LogTeamStatsViewState extends State<LogTeamStatsView> {
  Log _log = logDetailsBloc.logSubject.value;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(10),
        child: Align(alignment: Alignment.topCenter,child: Card(
            elevation: 10.0,
            child: Container(padding: EdgeInsets.only(bottom: 1),child: Table(
              children: _getTableRows(),
            )))));
  }

  List<TableRow> _getTableRows() {
    List<TableRow> tableRows = List();
    tableRows.add(_getHeaderRow());
    tableRows.add(_getRow(
        "Kills",
        "${LogHelper.getKillsSum(_log, "Red")}",
        "${LogHelper.getKillsSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        "Deaths",
        "${LogHelper.getDeathsSum(_log, "Red")}",
        "${LogHelper.getDeathsSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        "Assists",
        "${LogHelper.getAssistsSum(_log, "Red")}",
        "${LogHelper.getAssistsSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        "Damage",
        "${LogHelper.getDamageSum(_log, "Red")}",
        "${LogHelper.getDamageSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        "Damage Taken",
        "${LogHelper.getDamageTakenSum(_log, "Red")}",
        "${LogHelper.getDamageTakenSum(_log, "Blue")}"));
    tableRows.add(_getRow("Caps", "${LogHelper.getCapSum(_log, "Red")}",
        "${LogHelper.getCapSum(_log, "Blue")}"));
    tableRows.add(_getRow(
        "Charges",
        "${LogHelper.getChargeSum(_log, "Red")}",
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
        "${LogHelper.getMedkitsHPSum(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getMedkitsHPSum(_log, "Blue").toStringAsFixed(2)}"));

    tableRows.add(_getRow(
        "Headshots",
        "${LogHelper.getHeadshotsSum(_log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getHeadshotsSum(_log, "Blue").toStringAsFixed(2)}"));

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
            border: Border(bottom: BorderSide(color: AppUtils.lightGreyColor))),
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
