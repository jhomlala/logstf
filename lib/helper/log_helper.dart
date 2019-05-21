import 'package:logstf/model/class_kill.dart';
import 'package:logstf/model/heal_spread.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

class LogHelper {
  static List<Player> getOtherPlayersWithClass(
      Log log, String className, String excludedSteamId) {
    List<Player> allPlayers = log.players.values.toList();
    return allPlayers
        .where((player) =>
            excludedSteamId != player.steamId &&
            isClassPlayedByPlayer(player, className))
        .toList();
  }

  static bool isClassPlayedByPlayer(Player player, String className) {
    return player.classStats
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
    return player.classStats.map((classStat) => classStat.type).toList();
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

  static List<Player> getPlayersSortedByAssistsWithoutMedic(Log log) {
    List<Player> players = log.players.values.toList();
    players = players
        .where((player) => !getPlayerClasses(player).contains("medic"))
        .toList();
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
      if (medicKills == null){
        medicKills = 0;
      }
    }

    return kills * 0.39 +
        assists * 0.2 +
        damage * 0.01 +
        caps * 0.2 +
        medicKills * 0.2;
  }
}
