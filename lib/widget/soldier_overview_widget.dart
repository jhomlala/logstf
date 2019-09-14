import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

import 'base_overview_card.dart';
import 'class_icon.dart';

class SoldierOverviewWidget extends BaseOverviewCard {
  SoldierOverviewWidget(Player player, Log log) : super(player, log);

  @override
  _SoldierOverviewWidgetState createState() => _SoldierOverviewWidgetState();
}

class _SoldierOverviewWidgetState
    extends BaseOverviewCardState<SoldierOverviewWidget> {
  ClassStats _classStats;

  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "soldier";
    }).first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView(children: [
      Card(
          child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ClassIcon(playerClass: "soldier"),
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
                      "Airshots: ",
                      player.as.toString(),
                    ),
                    getPositionRow(
                        _getPlayerAirshotsPosition(), "overall top airshots", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Caps: ",
                      player.cpc.toString(),
                    ),
                    getPositionRow(getPlayerCapPosition(), "overall top caps", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Soldiers killed: ",
                      _getSoldierKills().toString(),
                    ),
                    getPositionRow(_getSoldierKilledPosition(),
                        "overall top soldiers killed", context)
                  ]),
                ],
              ))),
      getWeaponsCard(_classStats)
    ]));
  }

  int _getPlayerAirshotsPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByAirshots(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getSoldierKills() {
    return log.classKills[player.steamId].soldier;
  }

  int _getSoldierKilledPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedBySoldierKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }
}
