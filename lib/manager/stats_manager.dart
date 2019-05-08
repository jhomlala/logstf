import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/player.dart';

class StatsManager {
  static AveragePlayerStats getAveragePlayerStatsForAllPlayers(
      List<Player> players) {
    double averageKills = getAverage(getKills(players));
    double averageDeaths = getAverage(getDeaths(players));
    double averageAssists = getAverage(getAssists(players));

    return AveragePlayerStats(
        type: "ALL",
        averageKills: averageKills,
        averageDeaths: averageDeaths,
        averageAssists: averageAssists);
  }

  static AveragePlayerStats getAveragePlayerStatsForTeam(
      List<Player> players, String team) {
    double averageKills = getAverage(getKills(players, team: team));
    double averageDeaths = getAverage(getDeaths(players, team: team));
    double averageAssists = getAverage(getAssists(players, team: team));

    return AveragePlayerStats(
        type: team,
        averageKills: averageKills,
        averageDeaths: averageDeaths,
        averageAssists: averageAssists);
  }

  static List<int> getKills(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => player.kills).toList();
  }

  static List<int> getDeaths(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => player.deaths).toList();
  }

  static List<int> getAssists(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => player.assists).toList();
  }

  static List<Player> filterTeam(List<Player> players, String team) {
    if (team != null) {
      return players.where((player) => player.team == team).toList();
    } else {
      return players;
    }
  }

  static double getAverage(List<int> values) {
    var valuesSum = 0.0;
    values.forEach((value) => {valuesSum += value});
    return valuesSum / values.length;
  }
}
