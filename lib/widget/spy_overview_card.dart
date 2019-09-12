import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';

import 'package:logstf/model/player.dart';

import 'base_overview_card.dart';
import 'class_icon.dart';

class SpyOverviewCard extends BaseOverviewCard {
  SpyOverviewCard(Player player, Log log) : super(player, log);

  @override
  _SpyOverviewCardState createState() => _SpyOverviewCardState();
}

class _SpyOverviewCardState extends BaseOverviewCardState<SpyOverviewCard> {
  ClassStats _classStats;

  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "spy";
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
                    ClassIcon(playerClass: "spy"),
                    Container(
                        child: Text(
                      " Highlights",
                      style: TextStyle(fontSize: 20),
                    ))
                  ]),
                  getStatRow("Time played: ", getTimePlayed(_classStats)),
                  Row(children: [
                    getStatRow("Kills: ", player.kills.toString()),
                    getPositionRow(
                        getPlayerKillsPosition(), "top kills", context)
                  ]),

                  Row(children: [
                    getStatRow(
                      "Damage: ",
                      player.dmg.toString(),
                    ),
                    getPositionRow(
                        getPlayerDamagePosition(), "top damage", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "DA/M: ",
                      player.dapm.toString(),
                    ),
                    getPositionRow(getPlayerDAPMPosition(), "top DA/M", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Medics killed: ",
                      getMedicPicks().toString(),
                    ),
                    getPositionRow(getPlayerMedicsPickedPosition(),
                        "top medics killed", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Sniper killed: ",
                      _getSniperKills().toString(),
                    ),
                    getPositionRow(_getSniperKilledPosition(), "top sniper killed", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Backstabs: ",
                      player.backstabs.toString(),
                    ),
                    getPositionRow(_getBackstabsPosition(), "top backstabs", context)
                  ]),
                ],
              ))),
      getWeaponsCard(_classStats)
    ])));
  }

  int _getSniperKills() {
    return log.classKills[player.steamId].sniper;
  }

  int _getSniperKilledPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedBySniperKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getBackstabsPosition(){
    var sortedPlayers = LogHelper.getPlayersSortedByBackstabs(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }
}
