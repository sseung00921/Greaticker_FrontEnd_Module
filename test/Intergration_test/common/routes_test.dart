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

import 'package:greaticker/main.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    final projectDir = Directory.current.path;
    dotenv.load(fileName: "$projectDir/.env.test");
  });

  testWidgets('BottomTap move to right page', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key("homeBottomTapButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('HomeScreen')), findsOneWidget);

    await tester.tap(find.byKey(Key("diaryBottomTapButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('HomeScreen')), findsNothing);
    expect(find.byKey(Key('DiaryScreen')), findsOneWidget);

    await tester.tap(find.byKey(Key("hall_of_fameBottomTapButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('DiaryScreen')), findsNothing);
    expect(find.byKey(Key('HallOfFameScreen')), findsOneWidget);

    await tester.tap(find.byKey(Key("popular_chartBottomTapButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('HallOfFameScreen')), findsNothing);
    expect(find.byKey(Key('PopularChartScreen')), findsOneWidget);
  });

  testWidgets('TopTap move to right page', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key("historyTopTapButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('HistoryScreen')), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key("profileTopTapButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('HistoryScreen')), findsNothing);
    expect(find.byKey(Key('ProfileScreen')), findsOneWidget);
  });
}
