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
}
