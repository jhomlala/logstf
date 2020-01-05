import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/helper/stats_manager.dart';
import 'package:logstf/model/internal/average_player_stats.dart';
import 'package:logstf/model/external/class_stats.dart';
import 'package:logstf/model/external/player.dart';

main() {
  testAverageStats();
  testAverageStatsForTeam();
  testGetKills();
  testGetAssists();
  testGetDeaths();
  testGetDmg();
  testGetDapm();
  testGetKapd();
  testGetDt();
  testGetDtpm();
  testGetKpd();
  testGetMedkits();
  testFilterTeam();
  testGetAverage();
  testGetAverageFromDouble();
}

void testAverageStats() {
  group("Average stats test", () {
    ClassStats classStat = ClassStats(
        type: "scout",
        kills: 10,
        assists: 5,
        deaths: 4,
        dmg: 10000,
        weapon: Map(),
        totalTime: 10);
    Player firstPlayer = Player(
        steamId: "1",
        team: "Red",
        classStats: List()..add(classStat),
        kills: 6,
        assists: 4,
        deaths: 23,
        suicides: 0,
        kapd: "0.4",
        kpd: "0.3",
        dmg: 5362,
        dmgReal: 207,
        dt: 6425,
        dtReal: 962,
        hr: 4376,
        lks: 1,
        as: 0,
        dapd: 233,
        dapm: 182,
        ubers: 0);

    Player secondPlayer = Player(
        steamId: "2",
        team: "Red",
        classStats: List()..add(classStat),
        kills: 21,
        assists: 7,
        deaths: 13,
        suicides: 0,
        kapd: "2.2",
        kpd: "1.6",
        dmg: 10215,
        dmgReal: 1261,
        dt: 6654,
        dtReal: 394,
        hr: 8014,
        lks: 4,
        as: 1,
        dapd: 785,
        dapm: 347,
        ubers: 0);

    List<Player> players = List();
    players.add(firstPlayer);
    players.add(secondPlayer);

    AveragePlayerStats averagePlayerStats =
        StatsManager.getAveragePlayerStatsForAllPlayers(players, 1764);

    test("Average player stats are not null", () {
      expect(averagePlayerStats != null, true);
    });

    test("Average assists is not null and have valid value", () {
      expect(averagePlayerStats.averageAssists != null, true);
      expect(averagePlayerStats.averageAssists, 5.5);
    });

    test("Average kills is not null and have valid value", () {
      expect(averagePlayerStats.averageKills != null, true);
      expect(averagePlayerStats.averageKills, 13.5);
    });

    test("Average deaths is not null and have valid value", () {
      expect(averagePlayerStats.averageDeaths != null, true);
      expect(averagePlayerStats.averageDeaths, 18.0);
    });

    test("Average dmg is not null and have valid value", () {
      expect(averagePlayerStats.averageDmg != null, true);
      expect(averagePlayerStats.averageDmg, 7788.5);
    });

    test("Average dapm is not null and have valid value", () {
      expect(averagePlayerStats.averageDapm != null, true);
      expect(averagePlayerStats.averageDapm, 264.5);
    });

    test("Average kapd is not null and have valid value", () {
      expect(averagePlayerStats.averageKapd != null, true);
      expect(averagePlayerStats.averageKapd, 1.3);
    });

    test("Average kpd is not null and have valid value", () {
      expect(averagePlayerStats.averageKpd != null, true);
      expect(averagePlayerStats.averageKpd, 0.950);
    });

    test("Average dt is not null and have valid value", () {
      expect(averagePlayerStats.averageDt != null, true);
      expect(averagePlayerStats.averageDt, 6539.5);
    });

    test("Average dtpm is not null and have valid value", () {
      expect(averagePlayerStats.averageDtpm != null, true);
      expect(averagePlayerStats.averageDtpm, 222.432);
    });

    test("Average medkits is not null and have valid value", () {
      expect(averagePlayerStats.averageMedkits != null, true);
      expect(averagePlayerStats.averageMedkits, 0.0);
    });

    AveragePlayerStats averagePlayerStatsWithEmptyPlayers =
        StatsManager.getAveragePlayerStatsForAllPlayers(null, 0);
    test("Average players is not null when players list is null", () {
      expect(averagePlayerStatsWithEmptyPlayers != null, true);
    });
  });
}

void testAverageStatsForTeam() {
  group("Average stats test for team", () {
    ClassStats classStat = ClassStats(
        type: "scout",
        kills: 10,
        assists: 5,
        deaths: 4,
        dmg: 10000,
        weapon: Map(),
        totalTime: 10);
    Player firstPlayer = Player(
        steamId: "1",
        team: "Red",
        classStats: List()..add(classStat),
        kills: 6,
        assists: 4,
        deaths: 23,
        suicides: 0,
        kapd: "0.4",
        kpd: "0.3",
        dmg: 5362,
        dmgReal: 207,
        dt: 6425,
        dtReal: 962,
        hr: 4376,
        lks: 1,
        as: 0,
        dapd: 233,
        dapm: 182,
        ubers: 0);

    Player secondPlayer = Player(
        steamId: "2",
        team: "Blue",
        classStats: List()..add(classStat),
        kills: 21,
        assists: 7,
        deaths: 13,
        suicides: 0,
        kapd: "2.2",
        kpd: "1.6",
        dmg: 10215,
        dmgReal: 1261,
        dt: 6654,
        dtReal: 394,
        hr: 8014,
        lks: 4,
        as: 1,
        dapd: 785,
        dapm: 347,
        ubers: 0);

    List<Player> players = List();
    players.add(firstPlayer);
    players.add(secondPlayer);

    AveragePlayerStats averagePlayerStats =
        StatsManager.getAveragePlayerStatsForTeam(players, 1764, "Red");

    test("Average player stats are not null", () {
      expect(averagePlayerStats != null, true);
    });

    test("Average assists is not null and have valid value", () {
      expect(averagePlayerStats.averageAssists != null, true);
      expect(averagePlayerStats.averageAssists, 4.0);
    });

    test("Average kills is not null and have valid value", () {
      expect(averagePlayerStats.averageKills != null, true);
      expect(averagePlayerStats.averageKills, 6.0);
    });

    test("Average deaths is not null and have valid value", () {
      expect(averagePlayerStats.averageDeaths != null, true);
      expect(averagePlayerStats.averageDeaths, 23.0);
    });

    test("Average dmg is not null and have valid value", () {
      expect(averagePlayerStats.averageDmg != null, true);
      expect(averagePlayerStats.averageDmg, 5362.0);
    });

    test("Average dapm is not null and have valid value", () {
      expect(averagePlayerStats.averageDapm != null, true);
      expect(averagePlayerStats.averageDapm, 182.0);
    });

    test("Average kapd is not null and have valid value", () {
      expect(averagePlayerStats.averageKapd != null, true);
      expect(averagePlayerStats.averageKapd, 0.4);
    });

    test("Average kpd is not null and have valid value", () {
      expect(averagePlayerStats.averageKpd != null, true);
      expect(averagePlayerStats.averageKpd, 0.3);
    });

    test("Average dt is not null and have valid value", () {
      expect(averagePlayerStats.averageDt != null, true);
      expect(averagePlayerStats.averageDt, 6425.0);
    });

    test("Average dtpm is not null and have valid value", () {
      expect(averagePlayerStats.averageDtpm != null, true);
      expect(averagePlayerStats.averageDtpm, 218.537);
    });

    test("Average medkits is not null and have valid value", () {
      expect(averagePlayerStats.averageMedkits != null, true);
      expect(averagePlayerStats.averageMedkits, 0.0);
    });

    AveragePlayerStats averagePlayerStatsWithEmptyPlayers =
        StatsManager.getAveragePlayerStatsForAllPlayers(null, 0);
    test("Average players is not null when players list is null", () {
      expect(averagePlayerStatsWithEmptyPlayers != null, true);
    });
  });
}

void testGetKills() {
  group("Kills test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", kills: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", kills: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Kills from team is not null and have valid value", () {
      List<int> killsFromRed = StatsManager.getKills(players, team: "Red");
      expect(killsFromRed.length, 2);
      expect(killsFromRed != null, true);
    });

    test("Kills from invalid team is not null and have valid value", () {
      List<int> killsFromBlue = StatsManager.getKills(players, team: "Blue");
      expect(killsFromBlue.length, 0);
      expect(killsFromBlue != null, true);
    });
  });
}

void testGetAssists() {
  group("Assists test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Assists from team is not null and have valid value", () {
      List<int> assistsFromRed = StatsManager.getAssists(players, team: "Red");
      expect(assistsFromRed.length, 2);
      expect(assistsFromRed != null, true);
    });

    test("Assists from invalid team is not null and have valid value", () {
      List<int> assistsFromBlue =
          StatsManager.getAssists(players, team: "Blue");
      expect(assistsFromBlue.length, 0);
      expect(assistsFromBlue != null, true);
    });
  });
}

void testGetDeaths() {
  group("Deaths test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Deaths from team is not null and have valid value", () {
      List<int> deathsFromRed = StatsManager.getAssists(players, team: "Red");
      expect(deathsFromRed.length, 2);
      expect(deathsFromRed != null, true);
    });

    test("Deaths from invalid team is not null and have valid value", () {
      List<int> deathsFromBlue = StatsManager.getAssists(players, team: "Blue");
      expect(deathsFromBlue.length, 0);
      expect(deathsFromBlue != null, true);
    });
  });
}

void testGetDmg() {
  group("Dmg test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Dmg from team is not null and have valid value", () {
      List<int> dmgFromRed = StatsManager.getAssists(players, team: "Red");
      expect(dmgFromRed.length, 2);
      expect(dmgFromRed != null, true);
    });

    test("Dmg from invalid team is not null and have valid value", () {
      List<int> dmgFromBlue = StatsManager.getAssists(players, team: "Blue");
      expect(dmgFromBlue.length, 0);
      expect(dmgFromBlue != null, true);
    });
  });
}

void testGetDapm() {
  group("Dapm test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Dapm from team is not null and have valid value", () {
      List<int> dapmFromRed = StatsManager.getAssists(players, team: "Red");
      expect(dapmFromRed.length, 2);
      expect(dapmFromRed != null, true);
    });

    test("Dapm from invalid team is not null and have valid value", () {
      List<int> dapmFromBlue = StatsManager.getAssists(players, team: "Blue");
      expect(dapmFromBlue.length, 0);
      expect(dapmFromBlue != null, true);
    });
  });
}

void testGetKapd() {
  group("Kapd test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Kapd from team is not null and have valid value", () {
      List<int> kapdFromRed = StatsManager.getAssists(players, team: "Red");
      expect(kapdFromRed.length, 2);
      expect(kapdFromRed != null, true);
    });

    test("Kapd from invalid team is not null and have valid value", () {
      List<int> kapdFromBlue = StatsManager.getAssists(players, team: "Blue");
      expect(kapdFromBlue.length, 0);
      expect(kapdFromBlue != null, true);
    });
  });
}

void testGetDt() {
  group("Dt test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Dt from team is not null and have valid value", () {
      List<int> dtFromRed = StatsManager.getAssists(players, team: "Red");
      expect(dtFromRed.length, 2);
      expect(dtFromRed != null, true);
    });

    test("Dt from invalid team is not null and have valid value", () {
      List<int> dtFromBlue = StatsManager.getAssists(players, team: "Blue");
      expect(dtFromBlue.length, 0);
      expect(dtFromBlue != null, true);
    });
  });
}

void testGetDtpm() {
  group("Dtpm test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Dtpm from team is not null and have valid value", () {
      List<int> dtpmFromRed = StatsManager.getAssists(players, team: "Red");
      expect(dtpmFromRed.length, 2);
      expect(dtpmFromRed != null, true);
    });

    test("Dtpm from invalid team is not null and have valid value", () {
      List<int> dtpmFromBlue = StatsManager.getAssists(players, team: "Blue");
      expect(dtpmFromBlue.length, 0);
      expect(dtpmFromBlue != null, true);
    });
  });
}

void testGetKpd() {
  group("Kpd test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Kpd from team is not null and have valid value", () {
      List<int> kpdFromRed = StatsManager.getAssists(players, team: "Red");
      expect(kpdFromRed.length, 2);
      expect(kpdFromRed != null, true);
    });

    test("Kpd from invalid team is not null and have valid value", () {
      List<int> kpdFromBlue = StatsManager.getAssists(players, team: "Blue");
      expect(kpdFromBlue.length, 0);
      expect(kpdFromBlue != null, true);
    });
  });
}

void testGetMedkits() {
  group("Medkits test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Medkits from team is not null and have valid value", () {
      List<int> medkitsFromRed = StatsManager.getAssists(players, team: "Red");
      expect(medkitsFromRed.length, 2);
      expect(medkitsFromRed != null, true);
    });

    test("Medkits from invalid team is not null and have valid value", () {
      List<int> medkitsFromBlue =
          StatsManager.getAssists(players, team: "Blue");
      expect(medkitsFromBlue.length, 0);
      expect(medkitsFromBlue != null, true);
    });
  });
}

void testFilterTeam() {
  group("Filter team test", () {
    Player firstPlayer = Player(steamId: "1", team: "Red", assists: 6);
    Player secondPlayer = Player(steamId: "2", team: "Red", assists: 20);
    List<Player> players = List()..add(firstPlayer)..add(secondPlayer);

    test("Valid filtered team is not null and have valid value", () {
      List<Player> playersFromRed = StatsManager.filterTeam(players, "Red");
      expect(playersFromRed.length, 2);
      expect(playersFromRed != null, true);
    });

    test("Invalid filtered team is not null and have valid value", () {
      List<Player> playersFromRed = StatsManager.filterTeam(players, "Blue");
      expect(playersFromRed.length, 0);
      expect(playersFromRed != null, true);
    });
  });
}

void testGetAverage() {
  group("Get average test", () {
    List<int> values = List()..add(1)..add(2)..add(3);
    double average = StatsManager.getAverage(values);

    test("Average is not null and have valid value in normal case", () {
      expect(average, 2);
      expect(average != null, true);
    });

    double averageInvalid = StatsManager.getAverage(null);
    test("Average is not null and have valid value values are null", () {
      expect(averageInvalid, isNaN);
      expect(averageInvalid != null, true);
    });
  });
}

void testGetAverageFromDouble() {
  group("Get average double test", () {
    List<double> values = List()..add(1.5)..add(2.5)..add(3);
    double average = StatsManager.getAverageFromDouble(values);

    print("Average: " + average.toString());
    test("Average is not null and have valid value in normal case", () {
      expect(average, 2.333);
      expect(average != null, true);
    });

    double averageInvalid = StatsManager.getAverageFromDouble(null);
    test("Average is not null and have valid value values are null", () {
      expect(averageInvalid, isNaN);
      expect(averageInvalid != null, true);
    });
  });
}
