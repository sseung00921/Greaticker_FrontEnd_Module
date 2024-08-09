// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/layout/default_layout.dart';

import 'package:greaticker/main.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    dotenv.load(fileName: ".env");
  });

  testWidgets('CanNotFindBelowAccomplishmentComponentWhenNotScrolled', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Key("hall_of_fameBottomTapButton")));
    await tester.pumpAndSettle();


  });

  testWidgets('CanFindBelowAccomplishmentComponentWhenScrolled', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Key("hall_of_fameBottomTapButton")));
    await tester.pumpAndSettle();
  });
}
