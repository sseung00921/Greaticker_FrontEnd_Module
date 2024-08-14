// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/layout/default_layout.dart';

import 'package:greaticker/main.dart';

void main() {

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    final projectDir = Directory.current.path;
    dotenv.load(fileName: "$projectDir/.env.test");
  });


  testWidgets('MyApp is in defaultLayout', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('DefaultLayout')), findsOneWidget);
    expect(find.byKey(Key('CommonAppBar')), findsOneWidget);
    expect(find.byKey(Key('CommonBottomNavigationBar')), findsOneWidget);
  });


  testWidgets('BottomNavigationBar disappear when TopTabButton clicked', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key("historyTopTapButton")));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('CommonBottomNavigationBar')), findsNothing);
  });


}
