import 'package:flutter/material.dart';
import 'package:logstf/model/class_kill.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/widget/class_icon.dart';
import 'package:logstf/widget/table_header_widget.dart';

class LogPlayerKillsView extends StatefulWidget {
  final Log log;
  final Player player;

  const LogPlayerKillsView(this.log, this.player);

  @override
  _LogPlayerKillsViewState createState() => _LogPlayerKillsViewState();
}

class _LogPlayerKillsViewState extends State<LogPlayerKillsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
            child: Card(
                elevation: 10,
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Table(
                    columnWidths: {
                      0: FractionColumnWidth(0.25),
                      1: FractionColumnWidth(0.22),
                      2: FractionColumnWidth(0.28),
                      3: FractionColumnWidth(0.25)
                    },
                    children: _getTableRows(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1),
                  )
                ]))));
  }

  int _sumStats(ClassKill classKill) {
    if (classKill == null) {
      return 0;
    }
    return classKill.scout +
        classKill.soldier +
        classKill.pyro +
        classKill.demoman +
        classKill.heavyweapons +
        classKill.engineer +
        classKill.medic +
        classKill.sniper +
        classKill.spy;
  }

  ClassKill _setupDefaultStats(){
    return ClassKill(
        scout: 0,
        soldier: 0,
        pyro: 0,
        demoman: 0,
        heavyweapons: 0,
        engineer: 0,
        medic: 0,
        sniper: 0,
        spy: 0);
  }

  List<TableRow> _getTableRows() {
    List<TableRow> tableRowsList = List<TableRow>();
    tableRowsList.add(_getHeaderTableRow());
    ClassKill classKill = widget.log.classKills[widget.player.steamId];
    if (classKill == null) {
      classKill = _setupDefaultStats();
    }

    ClassKill classKillAssists =
        widget.log.classKillAssists[widget.player.steamId];
    if (classKillAssists == null) {
      classKillAssists = _setupDefaultStats();
    }

    ClassKill classDeaths = widget.log.classDeaths[widget.player.steamId];
    if (classDeaths == null) {
      classDeaths = _setupDefaultStats();
    }

    int classKillSum = _sumStats(classKill);
    int classKillAssistsSum = _sumStats(classKillAssists);
    int classDeathsSum = _sumStats(classDeaths);

    tableRowsList.add(_getClassTableRow(
        "scout",
        classKill.scout,
        classKill.scout / classKillSum,
        classKillAssists.scout,
        classKillAssists.scout / classKillAssistsSum,
        classDeaths.scout,
        classDeaths.scout / classDeathsSum));

    tableRowsList.add(_getClassTableRow(
        "soldier",
        classKill.soldier,
        classKill.soldier / classKillSum,
        classKillAssists.soldier,
        classKillAssists.soldier / classKillAssistsSum,
        classDeaths.soldier,
        classDeaths.soldier / classDeathsSum));

    tableRowsList.add(_getClassTableRow(
        "pyro",
        classKill.pyro,
        classKill.pyro / classKillSum,
        classKillAssists.pyro,
        classKillAssists.pyro / classKillAssistsSum,
        classDeaths.pyro,
        classDeaths.pyro / classDeathsSum));

    tableRowsList.add(_getClassTableRow(
        "demoman",
        classKill.demoman,
        classKill.demoman / classKillSum,
        classKillAssists.demoman,
        classKillAssists.demoman / classKillAssistsSum,
        classDeaths.demoman,
        classDeaths.demoman / classDeathsSum));

    tableRowsList.add(_getClassTableRow(
        "heavyweapons",
        classKill.heavyweapons,
        classKill.heavyweapons / classKillSum,
        classKillAssists.heavyweapons,
        classKillAssists.heavyweapons / classKillAssistsSum,
        classDeaths.heavyweapons,
        classDeaths.heavyweapons / classDeathsSum));

    tableRowsList.add(_getClassTableRow(
        "engineer",
        classKill.engineer,
        classKill.engineer / classKillSum,
        classKillAssists.engineer,
        classKillAssists.engineer / classKillAssistsSum,
        classDeaths.engineer,
        classDeaths.engineer / classDeathsSum));

    tableRowsList.add(_getClassTableRow(
        "medic",
        classKill.medic,
        classKill.medic / classKillSum,
        classKillAssists.medic,
        classKillAssists.medic / classKillAssistsSum,
        classDeaths.medic,
        classDeaths.medic / classDeathsSum));

    tableRowsList.add(_getClassTableRow(
        "sniper",
        classKill.sniper,
        classKill.sniper / classKillSum,
        classKillAssists.sniper,
        classKillAssists.sniper / classKillAssistsSum,
        classDeaths.sniper,
        classDeaths.sniper / classDeathsSum));
    tableRowsList.add(_getClassTableRow(
        "spy",
        classKill.spy,
        classKill.spy / classKillSum,
        classKillAssists.spy,
        classKillAssists.spy / classKillAssistsSum,
        classDeaths.spy,
        classDeaths.spy / classDeathsSum));
    tableRowsList
        .add(getSummaryRow(classKillSum, classKillAssistsSum, classDeathsSum));

    return tableRowsList;
  }

  TableRow _getClassTableRow(
      String className,
      int kills,
      double killsPercentage,
      int killsAndAssists,
      double killsAndAssistsPercentage,
      int deaths,
      double deathsPercentage) {
    String classNameDisplayed = className;
    if (className == "heavyweapons") {
      classNameDisplayed = "heavy";
    }

    killsPercentage = killsPercentage * 100;
    if (killsPercentage.isNaN) {
      killsPercentage = 0;
    }
    killsAndAssistsPercentage = killsAndAssistsPercentage * 100;
    if (killsAndAssistsPercentage.isNaN) {
      killsAndAssistsPercentage = 0;
    }
    deathsPercentage = deathsPercentage * 100;
    if (deathsPercentage.isNaN) {
      deathsPercentage = 0;
    }

    return TableRow(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppUtils.getBorderColor(context)))),
        children: [
          Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(padding: EdgeInsets.only(left: 5)),
                ClassIcon(
                  playerClass: className,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                Text(AppUtils.capitalize(classNameDisplayed))
              ])),
          Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Center(
                  child:
                      Text("$kills (${killsPercentage.toStringAsFixed(1)}%)"))),
          Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Center(
                  child: Text(
                      "$killsAndAssists (${killsAndAssistsPercentage.toStringAsFixed(1)}%)"))),
          Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Center(
                  child: Text(
                      "$deaths (${deathsPercentage.toStringAsFixed(1)}%)")))
        ]);
  }

  TableRow _getHeaderTableRow() {
    return TableRow(children: [
      TableHeaderWidget("CLASS", 1),
      TableHeaderWidget("KILLS", 0),
      TableHeaderWidget("KILLS + ASSISTS", 0),
      TableHeaderWidget("DEATHS", 2),
    ]);
  }

  TableRow getSummaryRow(
      int classKillSum, int classKillAssistsSum, int classDeathsSum) {
    return TableRow(children: [
      Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text("Total"))),
      Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text("$classKillSum"))),
      Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text("$classKillAssistsSum"))),
      Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text("$classDeathsSum")))
    ]);
  }
}
