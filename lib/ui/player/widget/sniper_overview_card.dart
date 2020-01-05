import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/external/class_stats.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/external/player.dart';
import 'package:logstf/util/application_localization.dart';

import '../../common/widget/class_icon.dart';
import 'base_overview_card.dart';

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
                            ClassIcon(playerClass: "sniper"),
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
                              "${applicationLocalization.getText("log_class_snipers_killed")}: ",
                              _getSniperKills().toString(),
                            ),
                            getPositionRow(_getSniperKilledPosition(), "${applicationLocalization.getText("log_class_overall_top_snipers_killed")}", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "${applicationLocalization.getText("log_class_headshots")}: ",
                              player.headshots.toString(),
                            ),
                            getPositionRow(_getHeadshotsPosition(), "${applicationLocalization.getText("log_class_overall_top_headshots")}", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "${applicationLocalization.getText("log_class_headshots_hits")}: ",
                              player.headshots.toString(),
                            ),
                            getPositionRow(_getHeadshotsHitsPosition(), "${applicationLocalization.getText("log_class_overall_top_headshot_hits")}", context)
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
