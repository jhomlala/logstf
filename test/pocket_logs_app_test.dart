import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logstf/main.dart';

void main(){
  testRootMaterialApp();
}

void testRootMaterialApp(){
  testWidgets("Material app tests", (WidgetTester tester) async{
    await tester.pumpWidget(PocketLogsApp());
    final materialAppFinder = find.byKey(Key("pocketLogsMaterialApp"));
    expect(materialAppFinder, findsOneWidget);

    final titleAppFinder = find.text("Pocket Logs");
    expect(titleAppFinder,findsOneWidget);
  });
}