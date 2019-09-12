import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

import 'base_overview_card.dart';
import 'class_icon.dart';

class HeavyOverviewCard extends BaseOverviewCard {
  HeavyOverviewCard(Player player, Log log) : super(player, log);

  @override
  _HeavyOverviewCardState createState() => _HeavyOverviewCardState();
}

class _HeavyOverviewCardState extends BaseOverviewCardState<HeavyOverviewCard> {
  ClassStats _classStats;

  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "heavyweapons";
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
                            ClassIcon(playerClass: "heavyweapons"),
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
                              "Assists: ",
                              player.assists.toString(),
                            ),
                            getPositionRow(
                                getPlayerAssistsPosition(), "top assists", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "KA/D: ",
                              player.kapd.toString(),
                            ),
                            getPositionRow(getPlayerKAPDPosition(), "top KA/D", context)
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
                              "Heavies killed: ",
                              _getHeavyKills().toString(),
                            ),
                            getPositionRow(_getHeavyKillsPosition(),
                                "top heavies killed", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "DT: ",
                              player.dt.toString(),
                            ),
                            getPositionRow(_getDamageTakenPosition(), "top DT", context)
                          ]),
                        ],
                      ))),
              getWeaponsCard(_classStats)
            ])));
  }

  int _getDamageTakenPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByDT(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getHeavyKills(){
    return log.classKills[player.steamId].heavyweapons;
  }

  int _getHeavyKillsPosition(){
    var sortedPlayers = LogHelper.getPlayersSortedByHeavyKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }
}
