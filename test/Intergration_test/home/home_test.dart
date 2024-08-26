import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/language/stickers.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/utils/got_sticker_utils.dart';
import 'package:greaticker/home/view/home_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../mocks/provider/hall_of_fame/api_response/mock_hall_of_fame_api_response_provider.dart';
import '../../mocks/provider/hall_of_fame/api_response/mock_hall_of_fame_api_response_provider_returning_duplicated_hall_of_fame_error.dart';
import '../../mocks/provider/home/project/api_response/mock_project_api_response_provider.dart';
import '../../mocks/provider/home/project/mock_project_provider_returning_already_got_today_sticker.dart';
import '../../mocks/provider/home/project/mock_project_provider_returning_compelete.dart';
import '../../mocks/provider/home/project/mock_project_provider_returning_error.dart';
import '../../mocks/provider/home/project/mock_project_provider_returning_in_progress.dart';
import '../../mocks/provider/home/project/mock_project_provider_returning_no_exist.dart';
import '../../mocks/provider/home/project/mock_project_provider_returning_reset.dart';
import '../../mocks/provider/home/sticker/mock_got_sticker_provider.dart';
import '../../mocks/provider/home/sticker/mock_got_sticker_provider_returning_already_got_today_sticker.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    final projectDir = Directory.current.path;
    dotenv.load(fileName: "$projectDir/.env.test");
  });

  testWidgets('Display the name of the returned project',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("앱 만들기"), findsOneWidget);
  });

  testWidgets(
      'Show the "Get Sticker" and "Delete Project" buttons when the status is "In Progress"',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['get_sticker']!),
        findsOneWidget);
    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['delete_project']!),
        findsOneWidget);
  });

  testWidgets('Show the "Create Projects" button when the status is "No Exist"',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningNoExist,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['no_goal_set']!),
        findsOneWidget);
    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['create_project']!),
        findsOneWidget);
  });

  testWidgets(
      'Show the "Create Projects" button and registering hall of fame button when the status is "Completed"',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningComplete,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("앱 만들기"), findsOneWidget);
    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['create_project']!),
        findsOneWidget);
    expect(
        find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['register_hall_of_fame']!),
        findsOneWidget);
  });

  testWidgets(
      'Display a project reset guidance modal when the status is "Reset"',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningReset,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['reset_project_notice']!),
        findsOneWidget);
  });

  testWidgets(
      'Show the retry button when an exception occurs during pagination',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningError,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!),
        findsOneWidget);
  });

  testWidgets('Attempt refetching when the retry button is clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningError,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
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

  testWidgets(
      'Show the calendar when "Show Calendar" button is clicked, and hide it when "Hide Calendar" button is clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          supportedLocales: [
            const Locale('en', 'US'), // 영어
            const Locale('ko', 'KR'), // 한국어
            // 필요에 따라 다른 로케일 추가
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(TableCalendar), findsNothing);

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['show_calendar']!));
    await tester.pumpAndSettle();

    expect(find.byType(TableCalendar), findsOneWidget);

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['hide_calendar']!));
    await tester.pumpAndSettle();

    expect(find.byType(TableCalendar), findsNothing);
  });

  testWidgets(
      'Show text input modal and creation completion modal when \"Create Projects\" is clicked from No Exist State',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningNoExist,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['create_project']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['create_project_try']!),
        findsOneWidget);

    await tester.enterText(find.byType(TextField), "new Project");
    await tester.pumpAndSettle();
    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['enter']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(
            COMMENT_DICT[dotenv.get(LANGUAGE)]!['create_project_complete']!),
        findsOneWidget);
  });

  testWidgets(
      'Show a guidance modal and text input modal and creation completion modal when \"Create Projects\" is clicked from Completed State',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningComplete,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['create_project']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]![
            'create_project_sticker_loss_notice']!),
        findsOneWidget);

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['yes']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['create_project_try']!),
        findsOneWidget);

    await tester.enterText(find.byType(TextField), "new Project");
    await tester.pumpAndSettle();
    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['enter']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(
            COMMENT_DICT[dotenv.get(LANGUAGE)]!['create_project_complete']!),
        findsOneWidget);
  });

  testWidgets(
      'Show a guidance modal and deletion completion modal when "Delete Project" is clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['delete_project']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['delete_project_try']!),
        findsOneWidget);

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['yes']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(
            COMMENT_DICT[dotenv.get(LANGUAGE)]!['delete_project_complete']!),
        findsOneWidget);
  });

  testWidgets(
      'Show a sticker acquisition guidance modal when the "Get Sticker" button is clicked',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    final mockProjectStateNotifier =
        container.read(mockProjectProviderReturningInProgress.notifier);
    final mockGotStickerStateNotifier =
        container.read(mockGotStickerProvider.notifier);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // mockDiaryProvider의 상태를 container와 공유
          mockProjectProviderReturningInProgress
              .overrideWithValue(mockProjectStateNotifier),
          mockGotStickerProvider.overrideWithValue(mockGotStickerStateNotifier),
        ],
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['get_sticker']!));
    await tester.pumpAndSettle();

    final ApiResponseBase currentResponseState =
        container.read(mockProjectProviderReturningInProgress);
    currentResponseState as ApiResponse;
    ProjectModel currentProjectState = currentResponseState.data as ProjectModel;

    final ApiResponseBase apiResponseState =
        container.read(mockGotStickerProvider);
    apiResponseState as ApiResponse;
    final currentGotStickerState = apiResponseState.data;
    currentGotStickerState as GotStickerModel;

    expect(find.byType(AlertDialog), findsOneWidget);

    expect(
        find.text(GotStickerUtils.gotStickerComment(
            currentProjectState,
            STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![
                currentGotStickerState.id]!['name']!)),
        findsOneWidget);
  });

  testWidgets(
      'Show today sticker already got guidance modal when the "Get Sticker" button is clicked',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    final mockProjectStateNotifier =
        container.read(mockProjectProviderReturningInProgress.notifier);
    final mockGotStickerStateNotifier =
        container.read(mockGotStickerProvider.notifier);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // mockDiaryProvider의 상태를 container와 공유
          mockProjectProviderReturningInProgress
              .overrideWithValue(mockProjectStateNotifier),
          mockGotStickerProvider.overrideWithValue(mockGotStickerStateNotifier),
        ],
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningAlreadyGotTodaySticker,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider:
                mockGotStickerProviderReturningAlreadyGotTodaySticker,
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
    expect(
        find.text(
            COMMENT_DICT[dotenv.get(LANGUAGE)]!['today_sticker_already_got']!),
        findsOneWidget);
  });

  testWidgets(
      'Show a goal completion guidance modal when the "Get Sticker" button is clicked with one day remaining to meet the completion criteria.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['get_sticker']!));
    await tester.pumpAndSettle();

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['close']!));
    await tester.pumpAndSettle();

    /**mockProjectProviderReturningInProgress는 28일차까지 완료한 상태를 항상 리턴함
         * 그래서 한번 스티커를 획득해서는 목표완료 팝업 모달이 뜨지 않음 **/
    expect(find.byType(AlertDialog), findsNothing);

    /**앞서 28일차에서 한번 스티커를 획득해서 29일차인 상태에서 다시 스티커 획득을 클릭.
         * 실제 환경에서는 하루에 스티커를 1개만 획득가능하지만 테스트 목 환경에서는
         * 원활한 테스트를 위해 이 제한이 없음**/
    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['get_sticker']!));
    await tester.pumpAndSettle();

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['close']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(
            COMMENT_DICT[dotenv.get(LANGUAGE)]!['complete_project_notice']!),
        findsOneWidget);
  });

  testWidgets('Show a circular progress indicator during loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: DIARY_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //로딩 끝난 이후엔 로딩바 사라짐
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Get sticker button increases progress value and text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    LinearProgressIndicator linearProgressIndicator =
        tester.widget(find.byType(LinearProgressIndicator));
    expect(linearProgressIndicator.value, 28 / 30);
    expect(find.text('28/30'), findsOneWidget);

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['get_sticker']!));
    await tester.pumpAndSettle();
    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['close']!));
    await tester.pumpAndSettle();

    linearProgressIndicator =
        tester.widget(find.byType(LinearProgressIndicator));
    expect(linearProgressIndicator.value, 29 / 30);
    expect(find.text('29/30'), findsOneWidget);
  });

  testWidgets(
      'Check marks are correctly displayed on the calendar based on the day in a row.',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    final mockProjectStateNotifier =
        container.read(mockProjectProviderReturningInProgress.notifier);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          mockProjectProviderReturningInProgress
              .overrideWithValue(mockProjectStateNotifier),
        ],
        child: MaterialApp(
          supportedLocales: [
            const Locale('en', 'US'), // 영어
            const Locale('ko', 'KR'), // 한국어
            // 필요에 따라 다른 로케일 추가
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningInProgress,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final ApiResponseBase currentResponseState =
    container.read(mockProjectProviderReturningInProgress);
    currentResponseState as ApiResponse;
    ProjectModel currentProjectState = currentResponseState.data as ProjectModel;

    await tester
        .tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['show_calendar']!));
    await tester.pumpAndSettle();

    TableCalendar tableCalendar = tester.widget(find.byType(TableCalendar));

    expect(
        tableCalendar.selectedDayPredicate!(
            currentProjectState.startDay!.subtract(Duration(days: 1))),
        false);
    expect(tableCalendar.selectedDayPredicate!(currentProjectState.startDay!),
        true);
    expect(
        tableCalendar.selectedDayPredicate!(currentProjectState.startDay!
            .add(Duration(days: currentProjectState.dayInARow! - 2))),
        true);
    expect(
        tableCalendar.selectedDayPredicate!(currentProjectState.startDay!
            .add(Duration(days: currentProjectState.dayInARow! - 1))),
        false);
    // expect(tableCalendar.selectedDayPredicate!(currentProjectState.startDay!), true);
  });

  testWidgets('Modal flow when the registering Hall of Fame button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningComplete,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find
        .text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['register_hall_of_fame']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['only_nickname']!),
        findsOneWidget);
    expect(
        find.text(
            COMMENT_DICT[dotenv.get(LANGUAGE)]!['both_nickname_and_auth_id']!),
        findsOneWidget);

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['next']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]![
            'register_hall_of_fame_complete']!),
        findsOneWidget);
  });

  testWidgets(
      'Show notification flow when Hall of Fame registration is duplicated',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(
            key: HOME_SCREEN_KEY,
            projectProvider: mockProjectProviderReturningComplete,
            projectApiResponseProvider: mockProjectApiResponseProvider,
            gotStickerProvider: mockGotStickerProvider,
            hallOfFameApiResponseProvider: mockHallOfFameApiResponseProviderReturningDuplicatedHallOfFameError,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find
        .text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['register_hall_of_fame']!));
    await tester.pumpAndSettle();

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['next']!));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(COMMENT_DICT[dotenv.get(LANGUAGE)]![
        'duplicated_hall_of_fame']!),
        findsOneWidget);
  });
}
