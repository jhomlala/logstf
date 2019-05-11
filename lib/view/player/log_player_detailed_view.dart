import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/view/player/log_player_class_compare_view.dart';
import 'package:logstf/view/player/log_player_general_view.dart';

import 'log_player_kills_view.dart';

class LogPlayerDetailedView extends StatefulWidget {
  final Log log;
  final Player player;
  final HashMap<String, AveragePlayerStats> averagePlayersStatsMap;

  const LogPlayerDetailedView(
      this.log, this.player, this.averagePlayersStatsMap);

  @override
  _LogPlayerDetailedViewState createState() => _LogPlayerDetailedViewState();
}

class _LogPlayerDetailedViewState extends State<LogPlayerDetailedView>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length:4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.log.getPlayerName(widget.player.steamId)),
        bottom: TabBar(controller: tabController, tabs: [
          Tab(
            text: "General",
            icon: Icon(Icons.info_outline),
          ),
          Tab(
            text: "Class compare",
            icon: Icon(Icons.info_outline),
          ),
          Tab(
            text: "Kills",
            icon: Icon(Icons.report),
          ),
          Tab(
            text: "Awards",
            icon: Icon(Icons.report),
          )
        ]),
      ),
      body: Container(
          child: TabBarView(controller: tabController, children: [
        LogPlayerGeneralView(
            widget.player, widget.averagePlayersStatsMap, widget.log.length),
        LogPlayerClassCompareView(widget.log, widget.player),
            LogPlayerKillsView(widget.log, widget.player),
            Container(),
      ])),
    );
  }
}
