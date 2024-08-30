import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/router/router.dart';
import 'package:greaticker/home/component/home_view.dart';
import 'package:greaticker/profile/component/profile_view.dart';
import 'package:greaticker/profile/view/profile_screen.dart';

import '../../mocks/provider/profile/api_response/mock_profile_api_response_provider.dart';
import '../../mocks/provider/profile/api_response/mock_profile_api_response_provider_returning_duplicated_name_error.dart';
import '../../mocks/provider/profile/mock_profile_provider.dart';
import '../../mocks/provider/profile/mock_profile_provider_returning_error.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    final projectDir = Directory.current.path;
    dotenv.load(fileName: "$projectDir/.env.test");
  });

  testWidgets('Display nickname in profile', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProfileScreen(
              key: PROFILE_SCREEN_KEY,
              profileProvider: mockProfileProvider,
              profileApiResponseProvider: mockProfileApiResponseProvider,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text("뾰롱뾰롱이"), findsOneWidget);
  });

  testWidgets('Modal flow on successful nickname change', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(
            key: PROFILE_SCREEN_KEY,
            profileProvider: mockProfileProvider,
            profileApiResponseProvider: mockProfileApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['change_nickname']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['change_nickname_completed']!), findsOneWidget);
  });

  testWidgets('Modal flow when the name is duplicated', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(
            key: PROFILE_SCREEN_KEY,
            profileProvider: mockProfileProvider,
            profileApiResponseProvider: mockProfileApiResponseProviderReturningDuplicatedNameError,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['change_nickname']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['duplicated_nickname']!), findsOneWidget);
  });
  

  testWidgets('Show retry button on error', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(
            key: PROFILE_SCREEN_KEY,
            profileProvider: mockProfileProviderReturningError,
            profileApiResponseProvider: mockProfileApiResponseProviderReturningDuplicatedNameError,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!),
        findsOneWidget);
  });

  testWidgets('Retry when the retry button is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(
            key: PROFILE_SCREEN_KEY,
            profileProvider: mockProfileProviderReturningError,
            profileApiResponseProvider: mockProfileApiResponseProviderReturningDuplicatedNameError,
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

  testWidgets('Show circular indicator during loading', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(
            key: PROFILE_SCREEN_KEY,
            profileProvider: mockProfileProviderReturningError,
            profileApiResponseProvider: mockProfileApiResponseProviderReturningDuplicatedNameError,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //로딩 끝난 이후엔 로딩바 사라짐
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
