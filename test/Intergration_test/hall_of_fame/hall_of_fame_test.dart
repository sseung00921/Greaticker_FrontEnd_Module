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
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/pagination_params.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_provider.dart';

import 'package:greaticker/hall_of_fame/view/hall_of_fame_screen.dart';

import 'package:greaticker/main.dart';

import '../../mocks/provider/hall_of_fame/mock_hall_of_fame_provider.dart';
import '../../mocks/provider/hall_of_fame/mock_hall_of_fame_provider_returning_error.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    final projectDir = Directory.current.path;
    dotenv.load(fileName: "$projectDir/.env.test");
  });

  testWidgets('Can Not find below HallOfFameCard when Not scrolled.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HallOfFameScreen(
            key: HALL_OF_FAME_SCREEN_KEY,
            provider: mockHallOfFameProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final targetCardKey = Key('HallOfFameCard-100');

    expect(find.byKey(targetCardKey), findsNothing);
  });

  testWidgets('Can find below HallOfFameCard when scrolled.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HallOfFameScreen(
            key: HALL_OF_FAME_SCREEN_KEY,
            provider: mockHallOfFameProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final targetCardKey = Key('HallOfFameCard-100');

    await tester.dragUntilVisible(
      find.byKey(targetCardKey),
      find.byKey(HALL_OF_FAME_SCREEN_KEY),
      const Offset(0, -300),
    );

    await tester.pumpAndSettle(Duration(seconds: 10));

    expect(find.byKey(targetCardKey), findsOneWidget);
  });

  testWidgets('show retry button when got exception during pagination.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HallOfFameScreen(
            key: HALL_OF_FAME_SCREEN_KEY,
            provider: mockHallOfFameProviderReturningError,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text("다시 시도"), findsOneWidget);
  });

  testWidgets('try refetching when retry button clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HallOfFameScreen(
            key: HALL_OF_FAME_SCREEN_KEY,
            provider: mockHallOfFameProviderReturningError,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    Widget widget = tester.widget(find.text("다시 시도"));
    expect(find.byWidget(widget), findsOneWidget);

    await tester.tap(find.text("다시 시도"));
    await tester.pumpAndSettle();

    expect(find.byWidget(widget), findsNothing);
    expect(find.text("다시 시도"), findsOneWidget);
  });

  testWidgets('show circular progress indicator when loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HallOfFameScreen(
            key: HALL_OF_FAME_SCREEN_KEY,
            provider: mockHallOfFameProvider,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //로딩 끝난 이후엔 로딩바 사라짐
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('refetch when refreshed)', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HallOfFameScreen(
            key: HALL_OF_FAME_SCREEN_KEY,
            provider: mockHallOfFameProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final targetCardKey = Key('HallOfFameCard-1');
    Widget widget = tester.widget(find.byKey(targetCardKey));
    expect(find.byWidget(widget), findsOneWidget);

    await tester.drag(
      find.byKey(HALL_OF_FAME_SCREEN_KEY),
      const Offset(0, 10000),
    );
    await tester.pumpAndSettle();

    expect(find.byWidget(widget), findsNothing);
    expect(find.byKey(targetCardKey), findsOneWidget);
  });
}
