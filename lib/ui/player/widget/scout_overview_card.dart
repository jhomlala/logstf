import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/external/class_stats.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/utils/application_localization.dart';

import '../../common/widget/class_icon.dart';
import 'base_overview_card.dart';

class ScoutOverviewCard extends BaseOverviewCard {
  ScoutOverviewCard(Player player, Log log) : super(player, log);

  @override
  State<StatefulWidget> createState() {
    return _ScoutOverviewCardState();
  }
}

class _ScoutOverviewCardState extends BaseOverviewCardState<ScoutOverviewCard> {
  ClassStats _classStats;

  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "scout";
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
                    ClassIcon(playerClass: "scout"),
                    Container(
                        child: Text(
                            " ${applicationLocalization.getText("log_class_highlights")}" ,
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
                    getStatRow("${applicationLocalization.getText("log_class_scouts_killed")}: ", getScoutKills().toString()),
                    getPositionRow(_getScoutKilledPosition(),
                        "${applicationLocalization.getText("log_class_overall_top_scouts_killed")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "${applicationLocalization.getText("log_class_caps")}: ",
                      player.cpc.toString(),
                    ),
                    getPositionRow(getPlayerCapPosition(), "${applicationLocalization.getText("log_class_overall_top_caps")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "${applicationLocalization.getText("log_class_medkits_picked")}: ",
                      player.medkits.toString(),
                    ),
                    getPositionRow(_getPlayerMedkitsPickedPosition(),
                        "${applicationLocalization.getText("log_class_overall_top_medkits_picked")}", context)
                  ]),
                ],
              ))),
      getWeaponsCard(_classStats)
    ])));
  }

  int getScoutKills() {
    if (log.classKills.containsKey(player.steamId)){
      return log.classKills[player.steamId].scout;
    } else {
      return 0;
    }

  }

  int _getScoutKilledPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByScoutKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerMedkitsPickedPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByMedkits(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }
}
