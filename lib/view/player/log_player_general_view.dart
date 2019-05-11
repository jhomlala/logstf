import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/table_header_widget.dart';

class LogPlayerGeneralView extends StatefulWidget {
  final Player player;
  final HashMap<String, AveragePlayerStats> averagePlayersStatsMap;
  final int length;

  const LogPlayerGeneralView(this.player, this.averagePlayersStatsMap, this.length);

  @override
  _LogPlayerGeneralViewState createState() => _LogPlayerGeneralViewState();
}

class _LogPlayerGeneralViewState extends State<LogPlayerGeneralView> {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: Colors.black),
      children: _getTableRows(),
    );
  }

  List<TableRow> _getTableRows() {
    var player = widget.player;
    List<TableRow> rows = List();
    var all = widget.averagePlayersStatsMap["ALL"];
    var team = widget.averagePlayersStatsMap[player.team];
    AveragePlayerStats opponent;
    if (player.team == "Red") {
      opponent = widget.averagePlayersStatsMap["Blue"];
    } else {
      opponent = widget.averagePlayersStatsMap["Red"];
    }
    rows.add(TableRow(children: [
      TableHeaderWidget("METRIC"),
      TableHeaderWidget("VALUE"),
      TableHeaderWidget("GLOB. AVG"),
      TableHeaderWidget("TEAM AVG"),
      TableHeaderWidget("OPPO. AVG")
    ]));
    rows.add(getStatRow("Kills", player.kills.toDouble(), all.averageKills,
        team.averageKills, opponent.averageKills));
    rows.add(getStatRow("Deaths", player.deaths.toDouble(), all.averageDeaths,
        team.averageDeaths, opponent.averageDeaths));
    rows.add(getStatRow("Assists", player.assists.toDouble(),
        all.averageAssists, team.averageAssists, opponent.averageAssists));
    rows.add(getStatRow("DA", player.dmg.toDouble(), all.averageDmg,
        team.averageDmg, opponent.averageDmg));
    rows.add(getStatRow("DAPM", player.dapm.toDouble(), all.averageDapm, team.averageDapm, opponent.averageDapm));
    rows.add(getStatRow("KAPD", double.parse(player.kapd), all.averageKapd, team.averageKapd, opponent.averageKapd));
    rows.add(getStatRow("KPD", double.parse(player.kpd), all.averageKpd, team.averageKpd, opponent.averageKpd));
    rows.add(getStatRow("DT", player.dt.toDouble(), all.averageDt, team.averageDt, opponent.averageDt));
    rows.add(getStatRow("DTPM", player.dt.toDouble()/(widget.length/60), all.averageDtpm, team.averageDtpm, opponent.averageDtpm));
    rows.add(getStatRow("HP", player.medkits.toDouble(), all.averageMedkits, team.averageMedkits, opponent.averageMedkits));

    return rows;
  }

  TableRow getStatRow(
    String name,
    double value,
    double allAverageValue,
    double teamAverageValue,
    double opponentAverageValue,
  ) {
    return TableRow(
      children: <Widget>[
        Center(
            child: Text(
          name,
          style: TextStyle(fontSize: 16),
        )),
        Center(
            child: Text(
          value.toStringAsFixed(2),
          style: TextStyle(fontSize: 14),
        )),
        _getAverageWidgetRow(allAverageValue, value >= allAverageValue),
        _getAverageWidgetRow(teamAverageValue, value >= teamAverageValue),
        _getAverageWidgetRow(
            opponentAverageValue, value >= opponentAverageValue),
      ],
    );
  }

  Widget _getAverageWidgetRow(double value, bool arrowUp) {
    var arrow = Icon(Icons.keyboard_arrow_up, color: Colors.green);
    if (!arrowUp) {
      arrow = Icon(Icons.keyboard_arrow_down, color: Colors.red);
    }
    return Center(
        child: Row(children: [arrow, Text(value.toStringAsFixed(2))]));
  }
}
