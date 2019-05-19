import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/util/app_utils.dart';

class LogTeamStatsView extends StatefulWidget {
  final Log log;

  const LogTeamStatsView({Key key, this.log}) : super(key: key);

  @override
  _LogTeamStatsViewState createState() => _LogTeamStatsViewState();
}

class _LogTeamStatsViewState extends State<LogTeamStatsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.deepPurple),
        padding: EdgeInsets.all(10),
        child: Align(alignment: Alignment.topCenter,child: Card(
            elevation: 10.0,
            child: Container(padding: EdgeInsets.only(bottom: 5),child: Table(
              children: _getTableRows(),
            )))));
  }

  List<TableRow> _getTableRows() {
    List<TableRow> tableRows = List();
    tableRows.add(_getHeaderRow());
    tableRows.add(_getRow(
        "Kills",
        "${LogHelper.getKillsSum(widget.log, "Red")}",
        "${LogHelper.getKillsSum(widget.log, "Blue")}"));
    tableRows.add(_getRow(
        "Deaths",
        "${LogHelper.getDeathsSum(widget.log, "Red")}",
        "${LogHelper.getDeathsSum(widget.log, "Blue")}"));
    tableRows.add(_getRow(
        "Assists",
        "${LogHelper.getAssistsSum(widget.log, "Red")}",
        "${LogHelper.getAssistsSum(widget.log, "Blue")}"));
    tableRows.add(_getRow(
        "Damage",
        "${LogHelper.getDamageSum(widget.log, "Red")}",
        "${LogHelper.getDamageSum(widget.log, "Blue")}"));
    tableRows.add(_getRow(
        "Damage Taken",
        "${LogHelper.getDamageTakenSum(widget.log, "Red")}",
        "${LogHelper.getDamageTakenSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Caps", "${LogHelper.getCapSum(widget.log, "Red")}",
        "${LogHelper.getCapSum(widget.log, "Blue")}"));
    tableRows.add(_getRow(
        "Charges",
        "${LogHelper.getChargeSum(widget.log, "Red")}",
        "${LogHelper.getChargeSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Drops", "${LogHelper.getDropSum(widget.log, "Red")}",
        "${LogHelper.getDropSum(widget.log, "Blue")}"));
    tableRows.add(_getRow(
        "KA/D",
        "${LogHelper.getTeamKAPD(widget.log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamKAPD(widget.log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "D/M",
        "${LogHelper.getTeamDamagePerMinute(widget.log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamDamagePerMinute(widget.log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "K/D",
        "${LogHelper.getTeamKillsPerDeaths(widget.log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamKillsPerDeaths(widget.log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "DT/M",
        "${LogHelper.getTeamDamageTakenPerMinute(widget.log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getTeamDamageTakenPerMinute(widget.log, "Blue").toStringAsFixed(2)}"));
    tableRows.add(_getRow(
        "HP pickups",
        "${LogHelper.getMedkitsSum(widget.log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getMedkitsSum(widget.log, "Blue").toStringAsFixed(2)}"));

    tableRows.add(_getRow(
        "HP from pickups",
        "${LogHelper.getMedkitsHPSum(widget.log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getMedkitsHPSum(widget.log, "Blue").toStringAsFixed(2)}"));

    tableRows.add(_getRow(
        "Headshots",
        "${LogHelper.getHeadshotsSum(widget.log, "Red").toStringAsFixed(2)}",
        "${LogHelper.getHeadshotsSum(widget.log, "Blue").toStringAsFixed(2)}"));

    tableRows.add(_getRow(
        "Sentries",
        "${LogHelper.getSentriesSum(widget.log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getSentriesSum(widget.log, "Blue").toStringAsFixed(0)}"));

    tableRows.add(_getRow(
        "Backstabs",
        "${LogHelper.getBackstabsSum(widget.log, "Red").toStringAsFixed(0)}",
        "${LogHelper.getBackstabsSum(widget.log, "Blue").toStringAsFixed(0)}"));
    return tableRows;
  }

  TableRow _getHeaderRow() {
    return TableRow(children: [
      Container(
          color: Colors.deepPurple,
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
          color: Colors.deepPurple,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(8))),
              height: 30,
              child: Center(
                  child: Text("BLUE",
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
