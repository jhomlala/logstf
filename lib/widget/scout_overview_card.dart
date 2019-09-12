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
    List<Widget> weapons = getWeaponWidgets(_classStats);
    return Container(
        child: Expanded(child: ListView(
            children: [
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
                                getPlayerKillsPosition(), "top kills", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Assists: ",
                              player.assists.toString(),
                            ),
                            getPositionRow(
                                getPlayerAssistsPosition(), "top assists",
                                context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "KA/D: ",
                              player.kapd.toString(),
                            ),
                            getPositionRow(
                                getPlayerKAPDPosition(), "top KA/D", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Damage: ",
                              player.dmg.toString(),
                            ),
                            getPositionRow(
                                getPlayerDamagePosition(), "top damage",
                                context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "DA/M: ",
                              player.dapm.toString(),
                            ),
                            getPositionRow(
                                getPlayerDAPMPosition(), "top DA/M", context)
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
                            getPositionRow(getPlayerCapPosition(),
                                "top caps", context)
                          ]),
                          Row(children: [
                            getStatRow(
                              "Scout kills: ",
                              getScoutKills().toString()
                            ),
                            getPositionRow(_getScoutKilledPosition(),
                                "top scout killed", context)
                          ]),
                        ],
                      ))),
              Card(
                  child: Container(
                      margin: EdgeInsets.all(5),
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
                          height: 240,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _classStats.weapon.length,
                                itemBuilder: (context, position) {
                                  return weapons[position];
                                }))
                      ])))
            ])));
  }
  int getScoutKills() {
    return log.classKills[player.steamId].scout;
  }

  int _getScoutKilledPosition(){
    var sortedPlayers = LogHelper.getPlayersSortedByScoutKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int _getPlayerMedkitsPickedPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByMedkits(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }



}
