import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

import 'base_overview_card.dart';
import 'class_icon.dart';

class SniperOverviewCard extends BaseOverviewCard {
  SniperOverviewCard(Player player, Log log) : super(player, log);

  @override
  _SniperOverviewCardState createState() => _SniperOverviewCardState();
}

class _SniperOverviewCardState extends BaseOverviewCardState<SniperOverviewCard> {
  ClassStats _classStats;

  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "sniper";
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
                            ClassIcon(playerClass: "sniper"),
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
                              getKillsAndAssistsPerDeath(_classStats).toStringAsFixed(1),
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
                                "overall top medics killed", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Snipers killed: ",
                              _getSniperKills().toString(),
                            ),
                            getPositionRow(_getSniperKilledPosition(), "overall top sniper killed", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Headshots: ",
                              player.headshots.toString(),
                            ),
                            getPositionRow(_getHeadshotsPosition(), "overall top headshots", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Headshots hits: ",
                              player.headshots.toString(),
                            ),
                            getPositionRow(_getHeadshotsHitsPosition(), "overall top headshots hits", context)
                          ]),
                        ],
                      ))),
              getWeaponsCard(_classStats)
            ])));
  }


  int _getSniperKills() {
    if (log.classKills.containsKey(player.steamId)) {
      return log.classKills[player.steamId].sniper;
    } else {
      return 0;
    }
  }

  int _getSniperKilledPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedBySniperKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getHeadshotsPosition(){
    var sortedPlayers = LogHelper.getPlayersSortedByHeadshots(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }
  int _getHeadshotsHitsPosition(){
    var sortedPlayers = LogHelper.getPlayersSortedByHeadshotsHits(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }


}
