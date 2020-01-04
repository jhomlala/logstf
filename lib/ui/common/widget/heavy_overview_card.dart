import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/application_localization.dart';

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
                    ClassIcon(playerClass: "heavyweapons"),
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
                      "${applicationLocalization.getText("log_class_heavies_killed")}: ",
                      _getHeavyKills().toString(),
                    ),
                    getPositionRow(_getHeavyKillsPosition(),
                        "${applicationLocalization.getText("log_class_overall_top_heavies_killed")}", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "DT: ",
                      player.dt.toString(),
                    ),
                    getPositionRow(
                        _getDamageTakenPosition(), "${applicationLocalization.getText("log_class_overall_top_dt")}", context)
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

  int _getHeavyKills() {
    if (log.classKills != null && log.classKills.containsKey(player.steamId)) {
      return log.classKills[player.steamId].heavyweapons;
    } else {
      return 0;
    }
  }

  int _getHeavyKillsPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByHeavyKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }
}
