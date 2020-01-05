import 'package:flutter/material.dart';
import 'package:logstf/model/external/class_stats.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/util/application_localization.dart';

import 'base_overview_card.dart';
import 'package:logstf/ui/common/widget/class_icon.dart';

class EngineerOverviewCard extends BaseOverviewCard {
  EngineerOverviewCard(Player player, Log log) : super(player, log);

  @override
  _EngineerOverviewCardState createState() => _EngineerOverviewCardState();
}

class _EngineerOverviewCardState
    extends BaseOverviewCardState<EngineerOverviewCard> {
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
                    ClassIcon(playerClass: "engineer"),
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
