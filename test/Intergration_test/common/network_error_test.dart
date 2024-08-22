import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/home/view/home_screen.dart';

import '../../mocks/provider/hall_of_fame/api_response/mock_hall_of_fame_api_response_provider.dart';
import '../../mocks/provider/home/project/api_response/mock_project_api_response_provider.dart';
import '../../mocks/provider/home/project/mock_project_provider_returning_in_progress.dart';
import '../../mocks/provider/home/sticker/mock_got_sticker_provider_returning_error.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    final projectDir = Directory.current.path;
    dotenv.load(fileName: "$projectDir/.env.test");
  });

  testWidgets('show network failed modal when network error occurred',
      (WidgetTester tester) async {
    /**여기서는 스티커를 얻다가 네트워크 Fail이 나는 상황을 가정하였다.
     * 그러나 공통적으로 모든 서버요청 메서드에는 똑같은 패턴이 적용되므로
     * 해당 테스트는 범용적인 네트워크 Fail 상황에 대한 Test이다 **/
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProviderReturningError,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['get_sticker']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!),
        findsOneWidget);
  });
}
