import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/base_overview_card.dart';

import 'class_icon.dart';

class DemomanOverviewCard extends BaseOverviewCard {
  DemomanOverviewCard(Player player, Log log) : super(player, log);

  @override
  _DemomanOverviewCardState createState() => _DemomanOverviewCardState();
}

class _DemomanOverviewCardState
    extends BaseOverviewCardState<DemomanOverviewCard> {
  ClassStats _classStats;

  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "demoman";
    }).first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
            child: ListView(children: [
      Card(
          child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ClassIcon(playerClass: "demoman"),
                    Container(
                        child: Text(
                      " Highlights",
                      style: TextStyle(fontSize: 20),
                    ))
                  ]),
                  getStatRow("Time played: ", getTimePlayed(_classStats)),
                  Row(children: [
                    getStatRow("Kills: ", _classStats.kills.toString()),
                    getPositionRow(
                        getPlayerKillsPosition(), "overall top kills", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Assists: ",
                      _classStats.assists.toString(),
                    ),
                    getPositionRow(getPlayerAssistsPosition(),
                        "overall top assists", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "K/D: ",
                      getKillsPerDeath(_classStats).toStringAsFixed(1),
                    ),
                    getPositionRow(getPlayerKillsPerDeathPosition(),
                        "overall top K/D", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "KA/D: ",
                      getKillsAndAssistsPerDeath(_classStats)
                          .toStringAsFixed(1),
                    ),
                    getPositionRow(
                        getPlayerKAPDPosition(), "overall top KA/D", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Damage: ",
                      _classStats.dmg.toString(),
                    ),
                    getPositionRow(getPlayerDamagePosition(),
                        "overall top damage", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "DA/M: ",
                      getDamagePerMinute(_classStats).toStringAsFixed(0),
                    ),
                    getPositionRow(
                        getPlayerDAPMPosition(), "overall top DA/M", context)
                  ]),
                  Divider(),
                  Row(children: [
                    getStatRow(
                      "Medics killed: ",
                      getMedicsKilled().toString(),
                    ),
                    getPositionRow(getPlayerMedicsPickedPosition(),
                        "top medics killed", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Demomans killed: ",
                      _getDemomansKilled().toString(),
                    ),
                    getPositionRow(_getDemomanKillsPosition(),
                        "overal top demomans killed", context)
                  ]),
                ],
              ))),
      getWeaponsCard(_classStats)
    ])));
  }

  int _getDemomansKilled() {
    return log.classKills[player.steamId].demoman;
  }

  int _getDemomanKillsPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByDemomanKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }
}
