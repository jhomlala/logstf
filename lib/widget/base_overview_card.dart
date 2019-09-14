import 'package:flutter/material.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/weapon_stats_widget.dart';

import 'class_icon.dart';

abstract class BaseOverviewCard extends StatefulWidget {
  final Player player;
  final Log log;

  const BaseOverviewCard(this.player, this.log);
}

abstract class BaseOverviewCardState<T extends BaseOverviewCard>
    extends State<T> {
  Player get player {
    return widget.player;
  }

  Log get log {
    return widget.log;
  }

  String getTimePlayed(ClassStats classStats) {
    int seconds = classStats.totalTime;
    int minutes = (seconds / 60).floor();
    int secondsLeft = seconds - minutes * 60;
    String minutesFormatted = minutes < 10 ? "0$minutes" : minutes.toString();
    String secondsFormatted =
        secondsLeft < 10 ? "0$secondsLeft" : secondsLeft.toString();
    return "$minutesFormatted:$secondsFormatted";
  }

  Widget getStatRow(String name, String value) {
    return Container(
        padding: EdgeInsets.only(top: 2, bottom: 2),
        child: Row(children: [
          Text(name),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w700),
          )
        ]));
  }

  Widget getPositionRow(int position, String name, BuildContext context) {
    Color color = Theme.of(context).textTheme.body1.color;
    if (position == 1) {
      color = Colors.yellow;
    }
    if (position == 2) {
      color = Colors.grey;
    } else if (position == 3) {
      color = Colors.deepOrangeAccent;
    }

    return Row(children: [
      Text("  ("),
      Text(
        "#$position",
        style: TextStyle(color: color),
      ),
      Text(" $name)")
    ]);
  }

  List<Widget> getWeaponWidgets(ClassStats classStats) {
    List<Widget> widgets = List();
    var weapons = classStats.weapon.entries.toList();
    weapons.sort((weapon1, weapon2) {
      return weapon2.value.dmg.compareTo(weapon1.value.dmg);
    });

    weapons.forEach((entry) {
      widgets.add(WeaponStatsWidget(entry.key, entry.value));
    });
    return widgets;
  }

  int getMedicsKilled() {
    if (log.classKills.containsKey(player.steamId)) {
      return log.classKills[player.steamId].medic;
    } else {
      return 0;
    }
  }

  int getPlayerKillsPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int getPlayerAssistsPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByAssists(log, true);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int getPlayerKAPDPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByKAPD(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int getPlayerDamagePosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByDamage(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int getPlayerDAPMPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByDAPM(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int getPlayerMedicsPickedPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByMedicKills(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int getPlayerCapPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByCaps(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int getPlayerKillsPerDeathPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByKillsPerDeath(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }

  int getPlayerPositionInSortedPlayersList(List<Player> sortedPlayers) {
    int playerIndex = -1;
    for (int index = 0; index < sortedPlayers.length; index++) {
      if (sortedPlayers[index].steamId == player.steamId) {
        playerIndex = index;
        break;
      }
    }
    if (playerIndex == -1) {
      playerIndex = sortedPlayers.length - 2;
    }

    var position = playerIndex + 1;
    return position;
  }

  Widget getWeaponsCard(ClassStats classStats) {
    List<Widget> weapons = getWeaponWidgets(classStats);
    return Card(
        child: Container(
            margin: EdgeInsets.all(5),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ClassIcon(playerClass: classStats.type),
                Container(
                    child: Text(
                  " Weapons stats",
                  style: TextStyle(fontSize: 20),
                ))
              ]),
              weapons.isEmpty
                  ? Container(
                      height: 100, child: Center(child: Text("No weapon data")))
                  : Container(
                      height: 240,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: classStats.weapon.length,
                          itemBuilder: (context, position) {
                            return weapons[position];
                          })),
            ])));
  }

  double getKillsPerDeath(ClassStats classStats) {
    int deaths = classStats.deaths;
    if (deaths == 0) {
      deaths = 1;
    }
    return classStats.kills / deaths;
  }

  double getKillsAndAssistsPerDeath(ClassStats classStats) {
    int deaths = classStats.deaths;
    if (deaths == 0) {
      deaths = 1;
    }
    return (classStats.kills + classStats.assists) / deaths;
  }

  double getDamagePerMinute(ClassStats classStats) {
    if (classStats.totalTime < 60) {
      return classStats.dmg.toDouble();
    }
    return classStats.dmg / (classStats.totalTime / 60);
  }

  int getPlayerAirshotsPosition() {
    var sortedPlayers = LogHelper.getPlayersSortedByAirshots(log);
    return getPlayerPositionInSortedPlayersList(sortedPlayers);
  }
}
