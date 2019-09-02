import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/helper/log_helper.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/player.dart';

import 'test_helper.dart';

main() {
  testGetOtherPlayersWithClass();
  testIsClassPlayedByPlayer();
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
    test("Class is not played when player is null", (){
      expect(nullPlayerCheck, false);
      expect(nullPlayerCheck != null, true);
    });
  });
}
