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

void main() {
  testWidgets('CheckIfMyAppInDefaultLayout', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(language: 'KO'));

    expect(find.byKey(Key('DefaultLayout')), findsOneWidget);
    expect(find.byKey(Key('CommonAppBar')), findsOneWidget);
    expect(find.byKey(Key('CommonBottomNavigationBar')), findsOneWidget);
  });

  testWidgets('CheckIfBottomTapMoveToRightPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(language: 'KO'));

    expect(find.byKey(Key('DefaultLayout')), findsOneWidget);
    expect(find.byKey(Key('CommonAppBar')), findsOneWidget);
    expect(find.byKey(Key('CommonBottomTap')), findsOneWidget);
  });

  testWidgets('CheckIfTopTapMoveToRightPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(language: 'KO'));

    expect(find.byKey(Key('DefaultLayout')), findsOneWidget);
    expect(find.byKey(Key('CommonAppBar')), findsOneWidget);
    expect(find.byKey(Key('CommonBottomTap')), findsOneWidget);
  });

  testWidgets('CheckIfTranslateKoreanDoRight', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(language: 'KO'));
    expect(find.text("홈"), findsWidgets);
    expect(find.text("Home"), findsNothing);
  });

  testWidgets('CheckIfTranslateEnglishDoRight', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(language: 'EN'));
    expect(find.text("Home"), findsWidgets);
    expect(find.text("홈"), findsNothing);
  });
}
