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
  String _appBarTitle;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_onTabChanged);
    _onTabChanged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        elevation: 0.0,
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(
                icon: Icon(Icons.info_outline),
              ),
              Tab(
                icon: Icon(Icons.swap_horiz),
              ),
              Tab(
                icon: Icon(Icons.location_searching),
              ),
              Tab(
                icon: Icon(Icons.flash_on),
              )
            ]),
      ),
      body: Container(
          child: TabBarView(controller: _tabController, children: [
        LogPlayerPlayerView(widget.player, widget.log),
        LogPlayerGeneralView(
            widget.player, widget.averagePlayersStatsMap, widget.log.length),
        LogPlayerClassCompareView(widget.log, widget.player),
        LogPlayerKillsView(widget.log, widget.player),
        LogPlayerAwardsView(widget.log, widget.player)
      ])),
    );
  }

  void _onTabChanged() {
    int index = _tabController.index;
    String playerName = widget.log.getPlayerName(widget.player.steamId);
    var tabName = "";
    switch (index) {
      case 0:
        tabName = "$playerName - Player overview";
        break;
      case 1:
        tabName = "$playerName - General stats";
        break;
      case 2:
        tabName = "$playerName - Class compare";
        break;
      case 3:
        tabName = "$playerName - Match matrix";
        break;
      case 4:
        tabName = "$playerName - Awards";
        break;
    }
    setState(() {
      _appBarTitle = tabName;
    });
  }
}
