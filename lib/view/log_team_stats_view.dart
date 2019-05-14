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
    return Table(
      children: _getTableRows(),
    );
  }

  List<TableRow> _getTableRows() {
    List<TableRow> tableRows = List();
    tableRows.add(_getHeaderRow());
    tableRows.add(_getRow("Kills","${LogHelper.getKillsSum(widget.log, "Red")}","${LogHelper.getKillsSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Deaths","${LogHelper.getDeathsSum(widget.log, "Red")}","${LogHelper.getDeathsSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Assists","${LogHelper.getAssistsSum(widget.log, "Red")}","${LogHelper.getAssistsSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Damage","${LogHelper.getDamageSum(widget.log, "Red")}","${LogHelper.getDamageSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Damage Taken","${LogHelper.getDamageTakenSum(widget.log, "Red")}","${LogHelper.getDamageTakenSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Caps","${LogHelper.getCapSum(widget.log, "Red")}","${LogHelper.getCapSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Charges","${LogHelper.getChargeSum(widget.log, "Red")}","${LogHelper.getChargeSum(widget.log, "Blue")}"));
    tableRows.add(_getRow("Drops","${LogHelper.getDropSum(widget.log, "Red")}","${LogHelper.getDropSum(widget.log, "Blue")}"));
    return tableRows;
  }

  TableRow _getHeaderRow() {
    return TableRow(children: [
      Container(
          decoration: BoxDecoration(color: AppUtils.darkBlueColor),
          height: 30,
          child: Center(
              child: Text("METRIC", style: TextStyle(color: Colors.white)))),
      Container(
          decoration: BoxDecoration(color: Colors.red),
          height: 30,
          child: Center(
              child: Text("RED", style: TextStyle(color: Colors.white)))),
      Container(
          decoration: BoxDecoration(color: Colors.blue),
          height: 30,
          child: Center(
              child: Text("BLUE", style: TextStyle(color: Colors.white))))
    ]);
  }

  TableRow _getRow(
      String metricName, String redTeamValue, String blueTeamValue) {
    return TableRow(
        children: [Center(child:Text(metricName)), Center(child: Text(redTeamValue)), Center(child:Text(blueTeamValue))]);
  }



}
