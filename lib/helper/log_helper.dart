import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logstf/model/class_kill.dart';
import 'package:logstf/model/heal_spread.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/match_type.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_const.dart';

class LogHelper {
  static HashMap<String, String> _weaponNames = HashMap();
  static HashMap<String, String> _weaponImages = HashMap();

  static String getWeaponImage(String weaponNameKey) {
    if (_weaponImages.isEmpty) {
      _initWeaponImages();
    }
    if (_weaponImages.containsKey(weaponNameKey)) {
      return _weaponImages[weaponNameKey];
    } else {
      return "https://wiki.teamfortress.com/w/images/thumb/1/1b/Item_icon_Scattergun.png/150px-Item_icon_Scattergun.png";
    }
  }

  static String getWeaponName(String weaponNameKey) {
    if (_weaponNames.isEmpty) {
      _initWeaponNames();
    }

    if (_weaponNames.containsKey(weaponNameKey)) {
      return _weaponNames[weaponNameKey];
    } else {
      return weaponNameKey;
    }
  }

  static void _initWeaponNames() {
    _weaponNames["scattergun"] = "Scattergun";
    _weaponNames["maxgun"] = "Lugermorph";
    _weaponNames["pistol_scout"] = "Pistol";
    _weaponNames["soda_popper"] = "Soda Popper";
    _weaponNames["wrap_assassin"] = "Wrap Assasin";
    _weaponNames["the_winger"] = "Winger";
    _weaponNames["pep_brawlerblaster"] = "Baby Face's Blaster";
    _weaponNames["back_scatter"] = "Back Scatter";
    _weaponNames["pep_pistol"] = "Baby Face's Blaster";

  }

  static void _initWeaponImages() {
    _weaponImages["scattergun"] =
        "https://wiki.teamfortress.com/w/images/thumb/1/1b/Item_icon_Scattergun.png/150px-Item_icon_Scattergun.png";
    _weaponImages["maxgun"] =
        "https://wiki.teamfortress.com/w/images/thumb/8/86/Item_icon_Lugermorph.png/150px-Item_icon_Lugermorph.png";
    _weaponImages["pistol_scout"] =
        "https://wiki.teamfortress.com/w/images/thumb/5/52/Item_icon_Pistol.png/150px-Item_icon_Pistol.png";
    _weaponImages["soda_popper"] =
        "https://wiki.teamfortress.com/w/images/thumb/f/f1/Item_icon_Soda_Popper.png/150px-Item_icon_Soda_Popper.png";
    _weaponImages["wrap_assassin"] =
        "https://wiki.teamfortress.com/w/images/thumb/6/6b/Item_icon_Wrap_Assassin.png/150px-Item_icon_Wrap_Assassin.png";
    _weaponImages["the_winger"] =
        "https://wiki.teamfortress.com/w/images/thumb/4/4e/Item_icon_Winger.png/150px-Item_icon_Winger.png";
    _weaponImages["pep_brawlerblaster"] =
        "https://wiki.teamfortress.com/w/images/thumb/e/e6/Item_icon_Baby_Face%27s_Blaster.png/150px-Item_icon_Baby_Face%27s_Blaster.png";
    _weaponImages["back_scatter"] = "https://wiki.teamfortress.com/w/images/thumb/1/11/Item_icon_Back_Scatter.png/150px-Item_icon_Back_Scatter.png";
  }

  static List<Player> getOtherPlayersWithClass(
      Log log, String className, String excludedSteamId) {
    List<Player> allPlayers =
        log.players != null ? log.players.values.toList() : List();
    return allPlayers
        .where((player) =>
            excludedSteamId != player.steamId &&
            isClassPlayedByPlayer(player, className))
        .toList();
  }

  static bool isClassPlayedByPlayer(Player player, String className) {
    return player != null &&
        player.classStats
                .where((classStats) => classStats.type == className)
                .length >
            0;
  }

  static ClassKill getClassKill(Log log, Player player) {
    return log.classKills[player.steamId];
  }

  static List<Player> getPlayers(Log log, String teamName, {String className}) {
    List<Player> allPlayers = log.players.values.toList();
    List<Player> teamPlayers =
        allPlayers.where((player) => player.team == teamName).toList();
    if (className != null) {
      teamPlayers = teamPlayers
          .where((player) => isClassPlayedByPlayer(player, className))
          .toList();
    }
    return teamPlayers;
  }

  static int sumDeaths(List<Player> players) {
    int deaths = 0;
    players.forEach((player) => deaths += player.deaths);
    return deaths;
  }

  static List<HealSpread> getHealSpread(Log log, String steamId) {
    List<HealSpread> healSpreadList = List();
    var healSpreadMap = log.healspread[steamId];
    if (healSpreadMap == null) {
      return null;
    }
    int sum = _getSumOfMap(healSpreadMap);
    healSpreadMap.forEach((steamId, value) {
      var player = log.players[steamId];
      healSpreadList.add(HealSpread(log.getPlayerName(steamId),
          getPlayerClasses(player), (value / sum) * 100, value));
    });
    healSpreadList.sort((healSpread1, healSpread2) =>
        healSpread2.percentage.compareTo(healSpread1.percentage));
    return healSpreadList;
  }

  static int _getSumOfMap(Map<String, int> map) {
    int sum = 0;
    map.values.forEach((value) => sum += value);
    return sum;
  }

  static List<Player> getPlayersWithClass(Log log, String className) {
    List<Player> allPlayers = log.players.values.toList();
    return allPlayers
        .where((player) => isClassPlayedByPlayer(player, className))
        .toList();
  }

  static List<String> getPlayerClasses(Player player) {
    return player.classStats != null
        ? player.classStats.map((classStat) => classStat.type).toList()
        : List();
  }

  static Map<String, int> getHealSpreadMapWithNames(Log log, String steamId) {
    var healSpreadMap = log.healspread[steamId];
    return healSpreadMap
        .map((steamId, heal) => MapEntry(log.getPlayerName(steamId), heal));
  }

  static int getKillsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.kills;
    });
    return sum;
  }

  static int getDeathsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.deaths;
    });
    return sum;
  }

  static int getAssistsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.assists;
    });
    return sum;
  }

  static int getDamageSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.dmg;
    });
    return sum;
  }

  static int getDamageTakenSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.dt;
    });
    return sum;
  }

  static int getCapSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.cpc;
    });
    return sum;
  }

  static int getChargeSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.ubers;
    });
    return sum;
  }

  static int getDropSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.drops;
    });
    return sum;
  }

  static double getTeamKAPD(Log log, String team) {
    var kills = getKillsSum(log, team);
    var assists = getAssistsSum(log, team);
    var deaths = getDeathsSum(log, team);
    return (kills + assists) / deaths;
  }

  static double getTeamDamagePerMinute(Log log, String team) {
    var damage = getDamageSum(log, team);
    return damage / (log.length / 60);
  }

  static double getTeamKillsPerDeaths(Log log, String team) {
    var kills = getKillsSum(log, team);
    var deaths = getDeathsSum(log, team);
    return kills / deaths;
  }

  static double getTeamDamageTakenPerMinute(Log log, String team) {
    var damageTaken = getDamageTakenSum(log, team);
    return damageTaken / (log.length / 60);
  }

  static int getMedkitsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.medkits;
    });
    return sum;
  }

  static int getMedkitsHPSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.medkitsHp;
    });
    return sum;
  }

  static int getHeadshotsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.headshots;
    });
    return sum;
  }

  static int getSentriesSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.sentries;
    });
    return sum;
  }

  static int getBackstabsSum(Log log, String team) {
    var sum = 0;
    log.players.values.where((player) => player.team == team).forEach((player) {
      sum += player.backstabs;
    });
    return sum;
  }

  static List<String> getPlayerNames(Log log) {
    List<Player> allPlayers = log.players.values.toList();
    return allPlayers
        .map((player) => log.getPlayerName(player.steamId))
        .toList();
  }

  static List<Player> getPlayersSortedByKills(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.kills.compareTo(player1.kills));
    return players;
  }

  static List<Player> getPlayersSortedByAssists(Log log, bool medicsIncluded) {
    List<Player> players = log.players.values.toList();
    if (!medicsIncluded) {
      players = players
          .where((player) => !getPlayerClasses(player).contains("medic"))
          .toList();
    }
    players
        .sort((player1, player2) => player2.assists.compareTo(player1.assists));
    return players;
  }

  static List<Player> getPlayersSortedByDamage(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.dmg.compareTo(player1.dmg));
    return players;
  }

  static List<Player> getPlayersSortedByMedicKills(Log log) {
    List<Player> players = log.players.values.toList();
    players = players
        .where((player) =>
            log.classKills[player.steamId] != null &&
            log.classKills[player.steamId].medic != null)
        .toList();
    players.sort((player1, player2) => log.classKills[player2.steamId].medic
        .compareTo(log.classKills[player1.steamId].medic));
    return players;
  }

  static List<Player> getPlayerSortedByMVPScore(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => getPlayerMVPScore(player2, log)
        .compareTo(getPlayerMVPScore(player1, log)));
    return players;
  }

  static double getPlayerMVPScore(Player player, Log log) {
    var kills = player.kills;
    var assists = player.assists;
    var damage = player.dmg;
    var caps = player.cpc;
    var medicKills = 0;
    if (log.classKills.containsKey(player.steamId)) {
      medicKills = log.classKills[player.steamId].medic;
      if (medicKills == null) {
        medicKills = 0;
      }
    }

    return kills * 0.39 +
        assists * 0.2 +
        damage * 0.01 +
        caps * 0.2 +
        medicKills * 0.2;
  }

  static List<Player> getPlayersSortedByKPD(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.kpd.compareTo(player1.kpd));
    return players;
  }

  static List<Player> getPlayersSortedByKAPD(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.kapd.compareTo(player1.kapd));
    return players;
  }

  static MatchType getMatchType(int playersCount, String mapName) {
    String matchType = "";
    Color color = Colors.lightBlue;
    if (playersCount % 2 == 0) {
      double half = playersCount / 2;
      matchType = "${half.toStringAsFixed(0)}v${half.toStringAsFixed(0)}";
    } else {
      matchType = "$playersCount players";
    }

    if (playersCount == 4) {
      if (mapName.contains("ultiduo")) {
        matchType = AppConst.ultiduoMode;
        color = Colors.pink;
      } else {
        matchType = AppConst.bballMode;
        color = Colors.teal;
      }
    }
    if (playersCount >= 12 && playersCount < 18) {
      matchType = AppConst.sixesMode;
      color = Colors.green;
    } else if (playersCount >= 18) {
      matchType = AppConst.highlanderMode;
      color = Colors.orange;
    }
    return MatchType(matchType, color);
  }

  static getDamagePerMinute(Player player, int length) {
    var damage = player.dmg;
    return damage / (length / 60);
  }

  static getPlayersSortedByDAPM(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => getDamagePerMinute(player2, log.length)
        .compareTo(getDamagePerMinute(player1, log.length)));
    return players;
  }

  static getPlayersSortedByMedkits(Log log) {
    List<Player> players = log.players.values.toList();
    players
        .sort((player1, player2) => player2.medkits.compareTo(player1.medkits));
    return players;
  }

  static int getMedicKills(Player player, Log log) {
    if (log.classKills.containsKey(player.steamId)) {
      return log.classKills[player.steamId].medic;
    } else {
      return 0;
    }
  }

  static getPlayersSortedByMedicsKilled(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) =>
        getMedicKills(player2, log).compareTo(getMedicKills(player1, log)));
    return players;
  }

  static getPlayersSortedByCaps(Log log) {
    List<Player> players = log.players.values.toList();
    players.sort((player1, player2) => player2.cpc.compareTo(player1.cpc));
    return players;
  }
}
