import 'package:flutter/material.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/application_localization.dart';

import 'base_overview_card.dart';
import 'class_icon.dart';

class PyroOverviewCard extends BaseOverviewCard {
  PyroOverviewCard(Player player, Log log) : super(player, log);

  @override
  _PyroOverviewCardState createState() => _PyroOverviewCardState();
}

class _PyroOverviewCardState extends BaseOverviewCardState<PyroOverviewCard> {
  ClassStats _classStats;

  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "pyro";
    }).first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var applicationLocalization = ApplicationLocalization.of(context);
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
                    ClassIcon(playerClass: "pyro"),
                    Container(
                        child: Text(
                          " ${applicationLocalization.getText("log_class_highlights")}",
                          style: TextStyle(fontSize: 20),
                        ))
                  ]),
                  getStatRow("${applicationLocalization.getText("log_class_time_played")}: ", getTimePlayed(_classStats)),
                  Row(children: [
                    getStatRow("${applicationLocalization.getText("log_kills")}: ", _classStats.kills.toString()),
                    getPositionRow(
                        getPlayerKillsPosition(), "${applicationLocalization.getText("log_class_overall_top_kills")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "${applicationLocalization.getText("log_assists")}: ",
                      _classStats.assists.toString(),
                    ),
                    getPositionRow(getPlayerAssistsPosition(),
                        "${applicationLocalization.getText("log_class_overall_top_assists")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "K/D: ",
                      getKillsPerDeath(_classStats).toStringAsFixed(1),
                    ),
                    getPositionRow(getPlayerKillsPerDeathPosition(),
                        "${applicationLocalization.getText("log_class_overall_top_kpd")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "KA/D: ",
                      getKillsAndAssistsPerDeath(_classStats).toStringAsFixed(1),
                    ),
                    getPositionRow(
                        getPlayerKAPDPosition(), "${applicationLocalization.getText("log_class_overall_top_kapd")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "${applicationLocalization.getText("log_damage")}: ",
                      _classStats.dmg.toString(),
                    ),
                    getPositionRow(getPlayerDamagePosition(),
                        "${applicationLocalization.getText("log_class_overall_top_damage")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "DA/M: ",
                      getDamagePerMinute(_classStats).toStringAsFixed(0),
                    ),
                    getPositionRow(
                        getPlayerDAPMPosition(), "${applicationLocalization.getText("log_class_overall_top_dapm")}", context)
                  ]),
                  Divider(),
                  Row(children: [
                    getStatRow(
                      "${applicationLocalization.getText("log_class_medics_killed")}: ",
                      getMedicsKilled().toString(),
                    ),
                    getPositionRow(getPlayerMedicsPickedPosition(),
                        "${applicationLocalization.getText("log_class_overall_top_medics_killed")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "${applicationLocalization.getText("log_class_caps")}: ",
                      player.cpc.toString(),
                    ),
                    getPositionRow(getPlayerCapPosition(), "${applicationLocalization.getText("log_class_overall_top_caps")}", context)
                  ]),
                ],
              ))),
      getWeaponsCard(_classStats)
    ])));
  }
}
