import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/view/player/log_player_class_compare_view.dart';
import 'package:logstf/view/player/log_player_general_view.dart';

import 'log_player_awards_view.dart';
import 'log_player_kills_view.dart';
import 'log_player_player_view.dart';

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
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.log.getPlayerName(widget.player.steamId)),
        elevation: 0.0,
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Player",
                  icon: Icon(Icons.person)),
              Tab(
                text: "General",
                icon: Icon(Icons.info_outline),
              ),
              Tab(
                text: "Class",
                icon: Icon(Icons.swap_horiz),
              ),
              Tab(
                text: "Kills",
                icon: Icon(Icons.location_searching),
              ),
              Tab(
                text: "Awards",
                icon: Icon(Icons.flash_on),
              )
            ]),
      ),
      body: Container(
          child: TabBarView(controller: _tabController, children: [
            LogPlayerPlayerView(widget.player,widget.log),
        LogPlayerGeneralView(
            widget.player, widget.averagePlayersStatsMap, widget.log.length),
        LogPlayerClassCompareView(widget.log, widget.player),
        LogPlayerKillsView(widget.log, widget.player),
        LogPlayerAwardsView(widget.log, widget.player)
      ])),
    );
  }
}
