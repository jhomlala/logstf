import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
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

expectZeroWidgetByType(Type type){
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

PlayerObserved setupMockPlayerObserved(){
  return PlayerObserved(steamid64: "76561198024790295", name: "OLI");
}
