import 'package:flutter/material.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/base_overview_card.dart';

import 'class_icon.dart';

class DemomanOverviewCard extends BaseOverviewCard{
  DemomanOverviewCard(Player player, Log log) : super(player, log);

  @override
  _DemomanOverviewCardState createState() => _DemomanOverviewCardState();
}

class _DemomanOverviewCardState extends BaseOverviewCardState<DemomanOverviewCard> {
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
