import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/view/main_view.dart';

main() {
  testAppBar();
}

void testAppBar() {
  testWidgets("AppBarTests", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home:MainView()));
    final appBar = find.byKey(Key("mainViewAppBar"));
    expect(appBar, findsOneWidget);

    final title = find.text("Pocket Logs");
    expect(title, findsOneWidget);
  });
}
