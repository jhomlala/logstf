import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';
import 'package:logstf/widget/table_header_widget.dart';

class LogPlayerGeneralView extends StatefulWidget {
  final Player player;
  final HashMap<String, AveragePlayerStats> averagePlayersStatsMap;
  final int length;

  const LogPlayerGeneralView(
      this.player, this.averagePlayersStatsMap, this.length);

  @override
  _LogPlayerGeneralViewState createState() => _LogPlayerGeneralViewState();
}

class _LogPlayerGeneralViewState extends State<LogPlayerGeneralView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple,
        child: SingleChildScrollView(
            child: Column(
          children: _getStatsComparisonWidgets(),
        )));

  }

  List<Widget> _getStatsComparisonWidgets() {
    List<Widget> widgets = List();
    var player = widget.player;
    var all = widget.averagePlayersStatsMap["ALL"];
    var team = widget.averagePlayersStatsMap[player.team];
    AveragePlayerStats opponent;
    if (player.team == "Red") {
      opponent = widget.averagePlayersStatsMap["Blue"];
    } else {
      opponent = widget.averagePlayersStatsMap["Red"];
    }
    widgets.add(_getStatComparisonCard("Kills", player.kills.toDouble(),
        all.averageKills, team.averageKills, opponent.averageKills));
    widgets.add(_getStatComparisonCard("Deaths", player.deaths.toDouble(),
        all.averageDeaths, team.averageDeaths, opponent.averageDeaths));
    widgets.add(_getStatComparisonCard("Assists", player.assists.toDouble(),
        all.averageAssists, team.averageAssists, opponent.averageAssists));
    widgets.add(_getStatComparisonCard("Damage", player.dmg.toDouble(),
        all.averageDmg, team.averageDmg, opponent.averageDmg));
    widgets.add(_getStatComparisonCard("Damage per minute", player.dapm.toDouble(),
        all.averageDapm, team.averageDapm, opponent.averageDapm, playerValueFractionDigits: 2));
    widgets.add(_getStatComparisonCard("Kills & assists per death", double.parse(player.kapd),
        all.averageKapd, team.averageKapd, opponent.averageKapd, playerValueFractionDigits: 2));
    widgets.add(_getStatComparisonCard("Kills per death", double.parse(player.kpd),
        all.averageKpd, team.averageKpd, opponent.averageKpd, playerValueFractionDigits: 2));
    widgets.add(_getStatComparisonCard("Damage taken", player.dt.toDouble(),
        all.averageDt, team.averageDt, opponent.averageDt));
    widgets.add(_getStatComparisonCard(
        "Damage taken per minute",
        player.dt.toDouble() / (widget.length / 60),
        all.averageDtpm,
        team.averageDtpm,
        opponent.averageDtpm, playerValueFractionDigits: 2));
    widgets.add(_getStatComparisonCard("Medkits", player.medkits.toDouble(),
        all.averageMedkits, team.averageMedkits, opponent.averageMedkits));
    return widgets;
  }

  Card _getStatComparisonCard(String statName, double playerValue,
      double globalAvgValue, double teamAvgValue, double opponentTeamAvgValue,
      {int playerValueFractionDigits = 0}) {
    return Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(
              statName,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              playerValue.toStringAsFixed(playerValueFractionDigits),
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Container(
              height: 1,
              color: AppUtils.seashellColor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            _getAverageWidgetRow("Global average: ", globalAvgValue,
                playerValue >= globalAvgValue),
            _getAverageWidgetRow(
                "Team average: ", teamAvgValue, playerValue >= teamAvgValue),
            _getAverageWidgetRow("Opponent team average: ",
                opponentTeamAvgValue, playerValue >= opponentTeamAvgValue),
          ],
        ));
  }



  Widget _getAverageWidgetRow(String name, double value, bool arrowUp) {
    var arrow = Icon(Icons.keyboard_arrow_up, color: Colors.green);
    if (!arrowUp) {
      arrow = Icon(Icons.keyboard_arrow_down, color: Colors.red);
    }

    return Container(
        padding: EdgeInsets.only(left: 5),
        child: Row(children: [
          Text(
            name,
            style: TextStyle(fontSize: 16),
          ),
          Text(value.toStringAsFixed(2)),
          arrow
        ]));
  }
}
