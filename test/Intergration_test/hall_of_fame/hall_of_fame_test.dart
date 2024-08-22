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
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/hall_of_fame/component/hall_of_fame_card.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/view/hall_of_fame_screen.dart';

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

  testWidgets('Can see hitCount in HallOfFameCard.',
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

    expect(find.text("123"), findsWidgets);
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
    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!),
        findsOneWidget);
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

    Widget widget =
        tester.widget(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!));
    expect(find.byWidget(widget), findsOneWidget);

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!));
    await tester.pumpAndSettle();

    expect(find.byWidget(widget), findsNothing);
    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!),
        findsOneWidget);
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

  testWidgets('refetch when refreshed', (WidgetTester tester) async {
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

  testWidgets('show alertDialog When card is clicked',
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
    expect(find.byType(AlertDialog), findsNothing);

    final targetCardKey = Key('HallOfFameCard-1');

    await tester.tap(find.byKey(targetCardKey));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Show the delete button for items I created in the Hall of Fame', (WidgetTester tester) async {
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

    expect(find.byKey(Key("HallOfFameCardDeleteButton-3")), findsNothing);
    expect(find.byKey(Key("HallOfFameCardDeleteButton-4")), findsOneWidget);
  });

  testWidgets('Show a red heart for items I hit good and a gray heart for items I did not hit good in the Hall of Fame', (WidgetTester tester) async {
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

    Icon IconInCardHitGoodByMe = tester.widget(find.byKey(Key("HallOfFameCardHitGoodIcon-3")));
    Icon IconInCardNotHitGoodByMe = tester.widget(find.byKey(Key("HallOfFameCardHitGoodIcon-4")));

    expect(IconInCardHitGoodByMe.color, Colors.red);
    expect(IconInCardNotHitGoodByMe.color, Colors.grey);
  });

  testWidgets('Display a delete confirmation modal when a Hall of Fame card is deleted', (WidgetTester tester) async {
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

    IconButton deleteCardButton = tester.widget(find.byKey(Key("HallOfFameCardDeleteButton-4")));
    await tester.tap(find.byWidget(deleteCardButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['delete_hall_of_fame_complete']!), findsOneWidget);
  });
}
