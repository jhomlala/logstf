import 'package:logstf/model/average_player_stats.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/util/app_utils.dart';

class StatsManager {
  static AveragePlayerStats getAveragePlayerStatsForAllPlayers(
      List<Player> players, int length) {
    if (players == null){
      players = List<Player>();
    }
    double averageKills = getAverage(getKills(players));
    double averageDeaths = getAverage(getDeaths(players));
    double averageAssists = getAverage(getAssists(players));
    double averageDmg = getAverage(getDmg(players));
    double averageDapm = getAverage(getDapm(players));
    double averageKapd = getAverageFromDouble(getKapd(players));
    double averageKpd = getAverageFromDouble(getKpd(players));
    double averageDt = getAverage(getDt(players));
    double averageDtpm = getAverageFromDouble(getDtpm(players, length / 60));
    double averageMedkits = getAverage(getMedkits(players));

    return AveragePlayerStats(
        type: "ALL",
        averageKills: averageKills,
        averageDeaths: averageDeaths,
        averageAssists: averageAssists,
        averageDmg: averageDmg,
        averageDapm: averageDapm,
        averageKapd: averageKapd,
        averageKpd: averageKpd,
        averageDt: averageDt,
        averageDtpm: averageDtpm,
        averageMedkits: averageMedkits);
  }

  static AveragePlayerStats getAveragePlayerStatsForTeam(
      List<Player> players, int length, String team) {
    if (players == null) {
      players = List();
    }

    double averageKills = getAverage(getKills(players, team: team));
    double averageDeaths = getAverage(getDeaths(players, team: team));
    double averageAssists = getAverage(getAssists(players, team: team));
    double averageDmg = getAverage(getDmg(players, team: team));
    double averageDapm = getAverage(getDapm(players, team: team));
    double averageKapd = getAverageFromDouble(getKapd(players, team: team));
    double averageKpd = getAverageFromDouble(getKpd(players, team: team));
    double averageDt = getAverage(getDt(players, team: team));
    double averageDtpm =
        getAverageFromDouble(getDtpm(players, length / 60, team: team));
    double averageMedkits = getAverage(getMedkits(players, team: team));

    return AveragePlayerStats(
        type: team,
        averageKills: averageKills,
        averageDeaths: averageDeaths,
        averageAssists: averageAssists,
        averageDmg: averageDmg,
        averageDapm: averageDapm,
        averageKapd: averageKapd,
        averageKpd: averageKpd,
        averageDt: averageDt,
        averageDtpm: averageDtpm,
        averageMedkits: averageMedkits);
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

  static List<int> getDmg(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => player.dmg).toList();
  }

  static List<int> getDapm(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => player.dapm).toList();
  }

  static List<double> getKapd(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => double.parse(player.kapd)).toList();
  }

  static List<int> getDt(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => player.dt).toList();
  }

  static List<double> getDtpm(List<Player> players, double lengthInMinutes,
      {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => player.dt / lengthInMinutes).toList();
  }

  static List<double> getKpd(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => double.parse(player.kpd)).toList();
  }

  static List<int> getMedkits(List<Player> players, {String team}) {
    players = filterTeam(players, team);
    return players.map((player) => player.medkits).toList();
  }

  static List<Player> filterTeam(List<Player> players, String team) {
    if (team != null) {
      return players.where((player) => player.team == team).toList();
    } else {
      return players;
    }
  }

  static double getAverage(List<int> values) {
    if (values == null){
      values = List();
    }
    var valuesSum = 0.0;
    values
        .where((value) => value != null)
        .forEach((value) => {valuesSum += value});
    return AppUtils.roundDoubleToFractionDigits((valuesSum / values.length), 3);
  }

  static double getAverageFromDouble(List<double> values) {
    if (values == null){
      values = List();
    }
    var valuesSum = 0.0;
    values.forEach((value) => {valuesSum += value});
    return AppUtils.roundDoubleToFractionDigits((valuesSum / values.length), 3);
  }
}
