// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/layout/default_layout.dart';

import 'package:greaticker/main.dart';

Center mockChild = Center(
  child: Text(
    'HomeScreen',
    style: TextStyle(
      color: Colors.black,
    ),
  ),
);

Key MockKey = Key("DefaultLayout");

String MockTitleKey = "home";

void main() {
  testWidgets('CheckIfTranslateKoreanDoRight', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DefaultLayout(
          key: MockKey,
          language: "KO",
          child: mockChild,
          title_key: MockTitleKey),
    ));

    expect(find.text("홈"), findsWidgets);
    expect(find.text("Home"), findsNothing);
  });

  testWidgets('CheckIfTranslateEnglishDoRight', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DefaultLayout(
          key: MockKey,
          language: "EN",
          child: mockChild,
          title_key: MockTitleKey),
    ));

    expect(find.text("Home"), findsWidgets);
    expect(find.text("홈"), findsNothing);
  });
}
