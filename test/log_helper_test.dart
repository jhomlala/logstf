import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/external/class_kill.dart';
import 'package:logstf/model/external/heal_spread.dart';
import 'package:logstf/model/external/log.dart';
import 'package:logstf/model/external/player.dart';

import 'test_helper.dart';

main() {
  testGetOtherPlayersWithClass();
  testIsClassPlayedByPlayer();
  testGetClassKills();
  testGetPlayers();
  testSumDeaths();
  testGetHealSpread();
  testGetPlayersWithClass();
  testGetPlayerClasses();
  testGetHealSpreadMapWithNames();
}

void testGetOtherPlayersWithClass() {
  group("Get other players with class test", () {
    Log log = setupMockLog();
    List<Player> scoutPlayers =
        LogHelper.getOtherPlayersWithClass(log, "scout", "1");
    test("Found other players with same class", () {
      expect(scoutPlayers != null, true);
      expect(scoutPlayers.length, 1);
    });

    List<Player> pyroPlayers =
        LogHelper.getOtherPlayersWithClass(log, "pyro", "1");
    test("Not found other players with other class", () {
      expect(pyroPlayers != null, true);
      expect(pyroPlayers.length, 0);
    });

    Log logWithoutPlayers = Log();
    List<Player> medicPlayers =
        LogHelper.getOtherPlayersWithClass(logWithoutPlayers, "medic", "1");
    test("Not found other player when players are empty in the log", () {
      expect(medicPlayers != null, true);
      expect(medicPlayers.length, 0);
    });
  });
}

void testIsClassPlayedByPlayer() {
  group("Test is class played by player", () {
    Log log = setupMockLog();
    bool classPlayed =
        LogHelper.isClassPlayedByPlayer(log.players["1"], "scout");
    test("Class played by player", () {
      expect(classPlayed, true);
      expect(classPlayed != null, true);
    });
    bool classNotPlayed =
        LogHelper.isClassPlayedByPlayer(log.players["1"], "pyro");
    test("Class not played by player", () {
      expect(classNotPlayed, false);
      expect(classPlayed != null, true);
    });

    bool nullPlayerCheck = LogHelper.isClassPlayedByPlayer(null, "scout");
    test("Class is not played when player is null", () {
      expect(nullPlayerCheck, false);
      expect(nullPlayerCheck != null, true);
    });
  });
}

void testGetClassKills() {
  group("Test get class kills", () {
    Log log = setupMockLog();
    Player player = log.players["1"];
    ClassKill classKill = LogHelper.getClassKill(log, player);
    test("Class kills is not null and have valid value", () {
      expect(classKill != null, true);
      expect(classKill.engineer == 10, true);
      expect(classKill.scout == 0, false);
    });
  });
}

void testGetPlayers() {
  group("Test get players", () {
    Log log = setupMockLog();
    List<Player> redPlayers = LogHelper.getPlayers(log, "Red");
    List<Player> scoutsFromRed =
        LogHelper.getPlayers(log, "Red", className: "scout");
    List<Player> pyrosFromRed =
        LogHelper.getPlayers(log, "Red", className: "pyro");
    List<Player> bluePlayers = LogHelper.getPlayers(log, "Blue");
    List<Player> scoutsFromBlue =
        LogHelper.getPlayers(log, "Blue", className: "scout");

    List<Player> invalidTeamAndClassPlayers =
        LogHelper.getPlayers(log, "Test", className: "Test");

    test("Players from Red team are not null and have valid value", () {
      expect(redPlayers != null, true);
      expect(redPlayers.length, 1);
    });

    test(
        "Players from Rd team and valid class are not null and have valid value",
        () {
      expect(scoutsFromRed != null, true);
      expect(scoutsFromRed.length, 1);
    });

    test(
        "Players from Red team and invalid class are not null and have valid value",
        () {
      expect(pyrosFromRed != null, true);
      expect(pyrosFromRed.length, 0);
    });

    test("Players from Blue team are not null and have valid value", () {
      expect(bluePlayers != null, true);
      expect(bluePlayers.length, 2);
    });

    test(
        "Players from Blue team and invalid class are not null and have valid value",
        () {
      expect(scoutsFromBlue != null, true);
      expect(scoutsFromBlue.length, 1);
    });

    test(
        "Players from unknown team and unknown class are not null and have valid value",
        () {
      expect(invalidTeamAndClassPlayers != null, true);
      expect(invalidTeamAndClassPlayers.length, 0);
    });
  });
}

void testSumDeaths() {
  group("Test sum deaths", () {
    Log log = setupMockLog();
    int deaths =
        LogHelper.sumDeaths(List<Player>()..addAll(log.players.values));
    int deathsFromInvalidPlayers = LogHelper.sumDeaths(List());
    test(
        "Deaths number is not null and have valid value for valid players list",
        () {
      expect(deaths, 49);
      expect(deaths != null, true);
    });

    test(
        "Deaths number is not null and have valid value for empty players list",
        () {
      expect(deathsFromInvalidPlayers, 0);
      expect(deathsFromInvalidPlayers != null, true);
    });
  });
}

void testGetHealSpread() {
  group("Test get heal spread map", () {
    Log log = setupMockLog();
    List<HealSpread> healSpread = LogHelper.getHealSpread(log, "4");
    test("Heal spread list is not null and has valid value", () {
      expect(healSpread.length, 2);
      expect(healSpread != null, true);
    });

    test("Heal spread list elements has right values", () {
      expect(healSpread[0].name != null, true);
      expect(healSpread[0].percentage.toStringAsFixed(3), "66.667");
      expect(healSpread[1].name != null, true);
      expect(healSpread[1].percentage.toStringAsFixed(3), "33.333");
    });
  });
}

void testGetPlayersWithClass() {
  group("Test get players with class", () {
    Log log = setupMockLog();
    List<Player> scoutPlayers = LogHelper.getPlayersWithClass(log, "scout");
    List<Player> spyPlayers = LogHelper.getPlayersWithClass(log, "spy");

    test("Valid class players list is not null and has right value", () {
      expect(scoutPlayers != null, true);
      expect(scoutPlayers.length, 2);
    });

    test("Invalid class players list is not null and has right value", () {
      expect(spyPlayers != null, true);
      expect(spyPlayers.length, 0);
    });
  });
}

void testGetPlayerClasses() {
  group("Test get player classes", () {
    Log log = setupMockLog();
    List<String> classesForValidPlayer =
        LogHelper.getPlayerClasses(log.players["1"]);
    List<String> classesForInvalidPlayer =
        LogHelper.getPlayerClasses(Player(classStats: List()));
    test("Valid player classes list is not null and has right value", () {
      expect(classesForValidPlayer != null, true);
      expect(classesForValidPlayer.length, 1);
    });

    test("Invalid player classes list is not null and has right value", () {
      expect(classesForInvalidPlayer != null, true);
      expect(classesForInvalidPlayer.length, 0);
    });
  });
}

void testGetHealSpreadMapWithNames() {
  group("Test get heal spread map with names", () {
    Log log = setupMockLog();
    Map<String, int> healSpreadMap =
        LogHelper.getHealSpreadMapWithNames(log, "4");
    test("Heal spread map is not null and has valid values)", () {
      expect(healSpreadMap != null, true);
      expect(healSpreadMap.isNotEmpty, true);
    });
  });
}
