import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/player.dart';

class LogPlayerGeneralView extends StatefulWidget {
  final Player player;
  final HashMap<String, AveragePlayerStats> averagePlayersStatsMap;

  const LogPlayerGeneralView(this.player, this.averagePlayersStatsMap);

  @override
  _LogPlayerGeneralViewState createState() => _LogPlayerGeneralViewState();
}

class _LogPlayerGeneralViewState extends State<LogPlayerGeneralView> {
  @override
  Widget build(BuildContext context) {
    return Table(
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
    rows.add(TableRow(children: [Text("Metric"), Text("Value"), Text("Global avg"), Text("Team avg"), Text("Oppo. avg") ]));
    rows.add(getStatRow("Kills:", player.kills.toString(), all.averageKills,
        team.averageKills, opponent.averageKills));
    rows.add(getStatRow("Deaths:", player.deaths.toString(), all.averageDeaths,
        team.averageDeaths, opponent.averageDeaths));
    rows.add(getStatRow("Assists:", player.assists.toString(),
        all.averageAssists, team.averageAssists, opponent.averageAssists));
    rows.add(getStatRow("Damage:", player.dmg.toString(), 0, 0, 0));
    rows.add(getStatRow("Damage per minute:", player.dapm.toString(), 0, 0, 0));
    rows.add(getStatRow(
        "Kills & assists per death:", player.kapd.toString(), 0, 0, 0));
    rows.add(getStatRow("Kills per death:", player.kpd.toString(), 0, 0, 0));
    rows.add(getStatRow("Damage taken:", player.dt.toString(), 0, 0, 0));
    rows.add(
        getStatRow("Damage taken per minute:", player.dt.toString(), 0, 0, 0));
    rows.add(getStatRow("Health packs:", player.medkits.toString(), 0, 0, 0));
    rows.add(getStatRow("Headshots:", player.headshots.toString(), 0, 0, 0));
    rows.add(getStatRow("Airshots:", player.as.toString(), 0, 0, 0));
    return rows;
  }

  TableRow getStatRow(
    String name,
    String value,
    double averageValueAll,
    double teamAverageValue,
    double opponentAverageValue,
  ) {
    return TableRow(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontSize: 14),
        ),
        Text(value, style: TextStyle(fontSize: 14)),
        Text(
          averageValueAll.toStringAsFixed(2),
          style: TextStyle(fontSize: 14),
        ),
        Text(
          teamAverageValue.toStringAsFixed(2),
          style: TextStyle(fontSize: 14),
        ),
        Text(
          opponentAverageValue.toStringAsFixed(2),
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
