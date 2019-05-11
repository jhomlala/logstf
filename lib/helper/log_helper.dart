import 'package:logstf/model/class_kill.dart';
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
          .where((player) => isClassPlayedByPlayer(player, className)).toList();
    }
    return teamPlayers;
  }

  static int sumDeaths(List<Player> players) {
    int deaths = 0;
    players.forEach((player) => deaths += player.deaths);
    return deaths;
  }
}
