import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/weapon_stats_widget.dart';

import 'base_overview_card.dart';
import 'class_icon.dart';

class ScoutOverviewCard extends BaseOverviewCard {
  final Player player;
  final Log log;

  ScoutOverviewCard(this.player, this.log);

  @override
  State<StatefulWidget> createState() {
    return _ScoutOverviewCardState();
  }

}

class _ScoutOverviewCardState extends BaseOverviewCardState<ScoutOverviewCard> {
  ClassStats _classStats;

  Player get player {
    return widget.player;
  }

  Log get log {
    return widget.log;
  }

  @override
  void initState() {
    _classStats = widget.player.classStats.toList().where((classStats) {
      return classStats.type == "scout";
    }).first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> weapons = getWeaponWidgets(_classStats);
    return Container(
        child: SingleChildScrollView(
            child: Column(children: [
              Card(
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClassIcon(playerClass: "scout"),
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
                                _getPlayerKillsPosition(), "top kills", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Assists: ",
                              player.assists.toString(),
                            ),
                            getPositionRow(
                                _getPlayerAssistsPosition(), "top assists",
                                context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "KA/D: ",
                              player.kapd.toString(),
                            ),
                            getPositionRow(
                                _getPlayerKAPDPosition(), "top KA/D", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Damage: ",
                              player.dmg.toString(),
                            ),
                            getPositionRow(
                                _getPlayerDamagePosition(), "top damage",
                                context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "DA/M: ",
                              player.dapm.toString(),
                            ),
                            getPositionRow(
                                _getPlayerDAPMPosition(), "top DA/M", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Medkits picked: ",
                              player.medkits.toString(),
                            ),
                            getPositionRow(_getPlayerMedkitsPickedPosition(),
                                "top medkits picked", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Medics killed: ",
                              _getMedicPicks().toString(),
                            ),
                            getPositionRow(_getPlayerMedicsPickedPosition(),
                                "top medics killed", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Caps: ",
                              player.cpc.toString(),
                            ),
                            getPositionRow(_getPlayerCapPosition(),
                                "top caps", context)
                          ]),
                        ],
                      ))),
              Card(
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClassIcon(playerClass: "scout"),
                              Container(
                                  child: Text(
                                    " Weapons stats",
                                    style: TextStyle(fontSize: 20),
                                  ))
                            ]),
                        Container(
                            height: 250,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _classStats.weapon.length,
                                itemBuilder: (context, position) {
                                  return weapons[position];
                                }))
                      ])))
            ])));
  }

  int _getMedicPicks() {
    return log.classKills[player.steamId].medic;
  }

  int _getPlayerKillsPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByKills(log);
    return _getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerAssistsPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByAssists(log, true);
    return _getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerKAPDPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByKAPD(log);
    return _getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerDamagePosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByDamage(log);
    return _getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerDAPMPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByDAPM(log);
    return _getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerMedicsPickedPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByMedicKills(log);
    return _getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerMedkitsPickedPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByMedkits(log);
    return _getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerCapPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByCaps(log);
    return _getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerPositionInSortedPlayersList(List<Player> sortedPlayers) {
    int playerIndex = 0;
    for (int index = 0; index < sortedPlayers.length; index++) {
      if (sortedPlayers[index].steamId == player.steamId) {
        playerIndex = index;
        break;
      }
    }
    var position = playerIndex + 1;
    return position;
  }

}
