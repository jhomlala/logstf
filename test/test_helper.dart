import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

expectNWidgetByKey(int widgets, String key){
  expect(find.byKey(Key(key)),findsNWidgets(widgets));
}

expectNWidgetsByType(int widgets, Type widget){
  expect(find.byType(widget), findsNWidgets(widgets));
}

expectOneWidgetByKey(String key){
  expect(find.byKey(Key(key)), findsOneWidget);
}

expectOneWidgetByType(Type type){
  expect(find.byType(type), findsOneWidget);
}


expectOneWidgetWithText(String text){
  expect(find.text(text), findsOneWidget);
}

setupWidget(WidgetTester tester, Widget widget) async{
  await tester.pumpWidget(MaterialApp(home: widget));
}
