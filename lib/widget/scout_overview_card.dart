import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'base_overview_card.dart';
import 'class_icon.dart';

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
                      getKillsAndAssistsPerDeath(_classStats)
                          .toStringAsFixed(1),
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
                    getStatRow("Scouts killed: ", getScoutKills().toString()),
                    getPositionRow(_getScoutKilledPosition(),
                        "overall top scouts killed", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Caps: ",
                      player.cpc.toString(),
                    ),
                    getPositionRow(
                        getPlayerCapPosition(), "overall top caps", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Medkits picked: ",
                      player.medkits.toString(),
                    ),
                    getPositionRow(_getPlayerMedkitsPickedPosition(),
                        "overall top medkits picked", context)
                  ]),
                ],
              ))),
      getWeaponsCard(_classStats)
    ])));
  }

  int getScoutKills() {
    return log.classKills[player.steamId].scout;
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
