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

import '../../mocks/router/mock_router_with_logged_in_user.dart';
import '../../mocks/router/mock_router_with_no_logged_in_user.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    final projectDir = Directory.current.path;
    dotenv.load(fileName: "$projectDir/.env.test");

  });

  testWidgets('sendToLoginScreenIfGetMeFail',
          (WidgetTester tester) async {
            final ref = ProviderContainer();
            final mockRouterWithNoLoggedInUser = ref.read(mockRouterWithNoLoggedInUserProvider);

            await tester.pumpWidget(
              ProviderScope(
                child: MaterialApp.router(
                  routerConfig: mockRouterWithNoLoggedInUser,
                ),
              ),
            );

            expect(find.byKey(LOGIN_SCREEN_KEY), findsOneWidget);
            expect(find.byKey(HOME_SCREEN_KEY), findsNothing);
      });

  testWidgets('sendToHomeScreenIfGetMeSuccess',
          (WidgetTester tester) async {
        final ref = ProviderContainer();
        final mockRouterWithLoggedInUser = ref.read(mockRouterWithLoggedInUserProvider);

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp.router(
              routerConfig: mockRouterWithLoggedInUser,
            ),
          ),
        );

        expect(find.byKey(HOME_SCREEN_KEY), findsOneWidget);
        expect(find.byKey(LOGIN_SCREEN_KEY), findsNothing);
      });

}
