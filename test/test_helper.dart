import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/model/class_kill.dart';
import 'package:logstf/model/class_stats.dart';
import 'package:logstf/model/log.dart';
import 'package:logstf/model/log_short.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/model/player_observed.dart';

expectNWidgetByKey(int widgets, String key) {
  expect(find.byKey(Key(key)), findsNWidgets(widgets));
}

expectNWidgetsByType(int widgets, Type widget) {
  expect(find.byType(widget), findsNWidgets(widgets));
}

expectOneWidgetByKey(String key) {
  expect(find.byKey(Key(key)), findsOneWidget);
}

expectOneWidgetByType(Type type) {
  expect(find.byType(type), findsOneWidget);
}

expectZeroWidgetByType(Type type) {
  expect(find.byType(type), findsNothing);
}

expectOneWidgetWithText(String text) {
  expect(find.text(text), findsOneWidget);
}

setupWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(MaterialApp(home: widget));
}

setupWidgetWithScaffold(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
}

LogShort setupMockupLogShort() {
  var now = DateTime.now();
  return LogShort(
      id: now.millisecondsSinceEpoch,
      title: "Scrim $now",
      map: "pl_upwarrd",
      date: now.millisecondsSinceEpoch,
      views: 100,
      players: 2);
}

Future pauseTester(WidgetTester tester) async {
  await tester.idle();
  await tester.pump(Duration.zero);
  return;
}

PlayerObserved setupMockPlayerObserved() {
  return PlayerObserved(steamid64: "76561198024790295", name: "OLI");
}

Log setupMockLog() {
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

  Map<String, Player> players = Map();
  players["1"] = firstPlayer;
  players["2"] = secondPlayer;

  Map<String,ClassKill> classKills = Map();
  classKills["1"] = ClassKill(engineer: 10, scout: 10);
  classKills["2"] = ClassKill(scout: 10);

  return Log(players: players, classKills: classKills);
}
