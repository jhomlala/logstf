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
    List<Widget> weapons = getWeaponWidgets(_classStats);
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
                      "Airshots: ",
                      player.as.toString(),
                    ),
                    getPositionRow(
                        _getPlayerAirshotsPosition(), "top airshots", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Caps: ",
                      player.cpc.toString(),
                    ),
                    getPositionRow(getPlayerCapPosition(), "top caps", context)
                  ]),
                  Row(children: [
                    getStatRow(
                      "Soldiers killed: ",
                      _getSoldierKills().toString(),
                    ),
                    getPositionRow(_getSoldierKilledPosition(),
                        "top soldiers killed", context)
                  ]),
                ],
              ))),
      Card(
          child: Container(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ClassIcon(playerClass: "soldier"),
                  Container(
                      child: Text(
                    " Weapons stats",
                    style: TextStyle(fontSize: 20),
                  ))
                ]),
                Container(
                    height: 240,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _classStats.weapon.length,
                        itemBuilder: (context, position) {
                          return weapons[position];
                        }))
              ])))
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
