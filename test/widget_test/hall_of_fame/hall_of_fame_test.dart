// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/layout/default_layout.dart';
import 'package:greaticker/hall_of_fame/view/hall_of_fame_screen.dart';

import 'package:greaticker/main.dart';
import 'package:mockito/mockito.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    dotenv.load(fileName: ".env");
  });

  testWidgets('Can find below HallOfFameCard when scrolled. But can not find it when not scrolled', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HallOfFameScreen(key: HALL_OF_FAME_SCREEN_KEY),
        ),
      ),
    );
    await tester.pump(Duration(seconds: 10));
    final targetCardKey = Key('HallOfFameCard-11');

    expect(find.byKey(targetCardKey), findsNothing);

    await tester.dragUntilVisible(
      find.byKey(targetCardKey),
      find.byKey(HALL_OF_FAME_SCREEN_KEY),
      const Offset(0, -500),
    );
    await tester.pump(Duration(seconds: 10));

    expect(find.byKey(targetCardKey), findsOneWidget);
  });

  testWidgets('CanFindBelowAccomplishmentComponentWhenScrolled', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));

    await tester.tap(find.byKey(Key("hall_of_fameBottomTapButton")));
    await tester.pumpAndSettle();
  });
}
