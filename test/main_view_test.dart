import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/view/main_view.dart';

import 'test_helper.dart';

main() {
  testAppBar();
  testTabBar();
}

void testAppBar() {
  testWidgets("AppBar Tests", (WidgetTester tester) async {
    await setupWidget(tester, MainView());
    expectOneWidgetByKey("mainViewAppBar");
    expectOneWidgetWithText("Pocket Logs");
    expectOneWidgetByKey("mainViewSearchIcon");
    expectOneWidgetByKey("mainViewOverflowMenu");
  });
}

void testTabBar() {
  testWidgets("TabBar Tests", (WidgetTester tester) async {
    await setupWidget(tester, MainView());
    expectOneWidgetByKey("mainViewTabBar");
    expectNWidgetsByType(3, Tab);
    expectOneWidgetByType(TabBarView);
  });
}