import 'package:flutter/material.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

import 'base_overview_card.dart';
import 'class_icon.dart';

class EngineerOverviewCard extends BaseOverviewCard {
  EngineerOverviewCard(Player player, Log log) : super(player, log);

  @override
  _EngineerOverviewCardState createState() => _EngineerOverviewCardState();
}

class _EngineerOverviewCardState extends BaseOverviewCardState<EngineerOverviewCard> {
  ClassStats _classStats;
  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "engineer";
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
                            ClassIcon(playerClass: "engineer"),
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
                              "Caps: ",
                              player.cpc.toString(),
                            ),
                            getPositionRow(getPlayerCapPosition(), "top caps", context)
                          ]),
                        ],
                      ))),
              getWeaponsCard(_classStats)
            ])));
  }
}