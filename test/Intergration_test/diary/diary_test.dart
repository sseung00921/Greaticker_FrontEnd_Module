// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/view/diary_screen.dart';

import '../../mocks/provider/diary/mock_diary_provider.dart';
import '../../mocks/provider/diary/mock_diary_provider_returning_error.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    final projectDir = Directory.current.path;
    dotenv.load(fileName: "$projectDir/.env.test");
  });

  testWidgets('DiaryGridListView reorder test', (WidgetTester tester) async {
    final container = ProviderContainer();
    final mockDiaryStateNotifier = container.read(mockDiaryProvider.notifier);
    // 위젯 빌드
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // mockDiaryProvider의 상태를 container와 공유
          mockDiaryProvider.overrideWithValue(mockDiaryStateNotifier),
        ],
        child: MaterialApp(
          home: DiaryScreen(
            key: DIARY_SCREEN_KEY,
            provider: mockDiaryProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    //initial State
    final ApiResponseBase currentResponseState = container.read(mockDiaryProvider);
    currentResponseState as ApiResponse;
    DiaryModel currentState = currentResponseState.data as DiaryModel;

    List<String> initialExpectedList = [
      "1",
      "12",
      "21",
      "20",
      "8",
      "11",
      "24",
      "16",
      "3",
      "7",
      "14",
      "4",
      "10",
      "9",
      "19",
      "2",
      "22",
      "23",
      "15",
      "5",
      "18",
      "13",
      "6",
      "17"
    ];
    List<String> initialActualList = currentState.stickerInventory;
    expect(ListEquality().equals(initialActualList, initialExpectedList), true);

    //after reOrder
    Widget widgetDraggedForReOrder =
        tester.widget(find.byKey(Key("Sticker-12")));
    final gesture = await tester
        .startGesture(tester.getCenter(find.byWidget(widgetDraggedForReOrder)));
    await tester.pump(Duration(seconds: 2));

    await gesture.moveBy(const Offset(-300, 0));
    await gesture.up();

    //1번 스티커(0,0에 위치)랑  12(0,1에 위치)번 스티커 위치가 바뀌었는지 테스트
    List<String> afterReOrderExpectedList = [
      "12",
      "1",
      "21",
      "20",
      "8",
      "11",
      "24",
      "16",
      "3",
      "7",
      "14",
      "4",
      "10",
      "9",
      "19",
      "2",
      "22",
      "23",
      "15",
      "5",
      "18",
      "13",
      "6",
      "17"
    ];
    List<String> afterReOrderActualList = currentState.stickerInventory;
    expect(
        ListEquality().equals(afterReOrderActualList, afterReOrderExpectedList),
        true);
  });

  testWidgets('show sticker pop up modal When sticker is clicked',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: DiaryScreen(
                key: DIARY_SCREEN_KEY,
                provider: mockDiaryProvider,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byKey(Key("StickerPopUpModal-1")), findsNothing);

        final targetStickerKey = Key('Sticker-1');

        await tester.tap(find.byKey(targetStickerKey));
        await tester.pumpAndSettle();

        expect(find.byKey(Key("StickerPopUpModal-1")), findsOneWidget);
      });

  testWidgets(
      'favorite icon is filled in sticker pop up modal when this sticker is in favorite List',
          (WidgetTester tester) async {
        final container = ProviderContainer();
        final mockDiaryStateNotifier = container.read(mockDiaryProvider.notifier);
        // 위젯 빌드
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              // mockDiaryProvider의 상태를 container와 공유
              mockDiaryProvider.overrideWithValue(mockDiaryStateNotifier),
            ],
            child: MaterialApp(
              home: DiaryScreen(
                key: DIARY_SCREEN_KEY,
                provider: mockDiaryProvider,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final ApiResponseBase currentResponseState = container.read(mockDiaryProvider);
        currentResponseState as ApiResponse;
        DiaryModel currentState = currentResponseState.data as DiaryModel;

        //1번 스티커는 최애스티커 상태로 서버로부터 전달받음을 시뮬레이션
        expect(currentState.hitFavoriteList.contains("1"), true);

        final targetStickerKey = Key('Sticker-1');
        await tester.tap(find.byKey(targetStickerKey));
        await tester.pumpAndSettle();

        //채워진 하트는 있고
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        //빈 하트는 없음
        expect(find.byIcon(Icons.favorite_border_outlined), findsNothing);
      });

  testWidgets(
      'favorite icon is not filled in sticker pop up modal when this sticker is not in favorite List',
          (WidgetTester tester) async {
        final container = ProviderContainer();
        final mockDiaryStateNotifier = container.read(mockDiaryProvider.notifier);
        // 위젯 빌드
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              // mockDiaryProvider의 상태를 container와 공유
              mockDiaryProvider.overrideWithValue(mockDiaryStateNotifier),
            ],
            child: MaterialApp(
              home: DiaryScreen(
                key: DIARY_SCREEN_KEY,
                provider: mockDiaryProvider,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final ApiResponseBase currentResponseState = container.read(mockDiaryProvider);
        currentResponseState as ApiResponse;
        DiaryModel currentState = currentResponseState.data as DiaryModel;
        //21번 스티커는 최애스티커 상태가 아닌 상태로 서버로부터 전달받음을 시뮬레이션
        expect(currentState.hitFavoriteList.contains("21"), false);

        final targetStickerKey = Key('Sticker-21');
        await tester.tap(find.byKey(targetStickerKey));
        await tester.pumpAndSettle();

        //빈 하트는 있고
        expect(find.byIcon(Icons.favorite_border_outlined), findsOneWidget);
        //채워진 하트는 없음
        expect(find.byIcon(Icons.favorite), findsNothing);
      });

  testWidgets(
      'can not add favorite sticker when you already have three favorite one',
          (WidgetTester tester) async {
        final container = ProviderContainer();
        final mockDiaryStateNotifier = container.read(mockDiaryProvider.notifier);
        // 위젯 빌드
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              // mockDiaryProvider의 상태를 container와 공유
              mockDiaryProvider.overrideWithValue(mockDiaryStateNotifier),
            ],
            child: MaterialApp(
              home: DiaryScreen(
                key: DIARY_SCREEN_KEY,
                provider: mockDiaryProvider,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final ApiResponseBase currentResponseState = container.read(mockDiaryProvider);
        currentResponseState as ApiResponse;
        DiaryModel currentState = currentResponseState.data as DiaryModel;
        //해당 유저는 최애 스티커 3개를 이미 보유한 상태로 서버에서 전달받음을 시뮬레이션
        expect(currentState.hitFavoriteList.length, 3);

        final targetStickerKey = Key('Sticker-21');
        await tester.tap(find.byKey(targetStickerKey));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.favorite_border_outlined));
        await tester.pumpAndSettle();
        String comment = COMMENT_DICT[dotenv.get(LANGUAGE)]!['can_not_register_favorite_sticker_more_than_3']!;
        expect(find.text(comment), findsOneWidget);
      });

  testWidgets(
      'can remove one favorite sticker and add another one',
          (WidgetTester tester) async {
        final container = ProviderContainer();
        final mockDiaryStateNotifier = container.read(mockDiaryProvider.notifier);
        // 위젯 빌드
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              // mockDiaryProvider의 상태를 container와 공유
              mockDiaryProvider.overrideWithValue(mockDiaryStateNotifier),
            ],
            child: MaterialApp(
              home: DiaryScreen(
                key: DIARY_SCREEN_KEY,
                provider: mockDiaryProvider,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final ApiResponseBase currentResponseState = container.read(mockDiaryProvider);
        currentResponseState as ApiResponse;
        DiaryModel currentState = currentResponseState.data as DiaryModel;
        //해당 유저는 최애 스티커 3개를 이미 보유한 상태로 서버에서 전달받았고 1번은 최애스티커임을 시뮬레이션
        expect(currentState.hitFavoriteList.length, 3);
        expect(currentState.hitFavoriteList.contains("1"), true);

        final removedStickerKey = Key('Sticker-1');
        await tester.tap(find.byKey(removedStickerKey));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.favorite));
        await tester.pumpAndSettle();

        //하트 클릭시 1번 스티커가 최애스티커목록에서 제거됨을 확인
        expect(currentState.hitFavoriteList.length, 2);
        expect(currentState.hitFavoriteList.contains("1"), false);

        //팝업 해제
        await tester.tapAt(Offset(10, 10));
        await tester.pumpAndSettle();

        final newlyAddedStickerKey = Key('Sticker-8');
        await tester.tap(find.byKey(newlyAddedStickerKey));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.favorite_border_outlined));
        await tester.pumpAndSettle();

        //8번스티커 팝업모달에서 빈 하트 클릭시 8번 스티커가 최애스티커목록에서 새로이 추가됨을 확인.
        expect(currentState.hitFavoriteList.length, 3);
        expect(currentState.hitFavoriteList.contains("8"), true);
      });

  testWidgets('Can Not find below Sticker when Not scrolled.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: DiaryScreen(
            key: DIARY_SCREEN_KEY,
            provider: mockDiaryProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final targetStickerKey = Key('Sticker-17');

    expect(find.byKey(targetStickerKey), findsNothing);
  });

  testWidgets('Can find below Sticker when scrolled.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: DiaryScreen(
            key: DIARY_SCREEN_KEY,
            provider: mockDiaryProvider,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final targetStickerKey = Key('Sticker-17');

    await tester.dragUntilVisible(
      find.byKey(targetStickerKey),
      find.byKey(DIARY_SCREEN_KEY),
      const Offset(0, -300),
    );

    await tester.pumpAndSettle(Duration(seconds: 10));

    expect(find.byKey(targetStickerKey), findsOneWidget);
  });

  testWidgets('show retry button when got exception during pagination.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: DiaryScreen(
            key: DIARY_SCREEN_KEY,
            provider: mockDiaryProviderReturningError,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!), findsOneWidget);
  });

  testWidgets('try refetching when retry button clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: DiaryScreen(
            key: DIARY_SCREEN_KEY,
            provider: mockDiaryProviderReturningError,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    Widget widget = tester.widget(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!));
    expect(find.byWidget(widget), findsOneWidget);

    await tester.tap(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!));
    await tester.pumpAndSettle();

    expect(find.byWidget(widget), findsNothing);
    expect(find.text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!), findsOneWidget);
  });

  testWidgets('show circular progress indicator when loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: DiaryScreen(
            key: DIARY_SCREEN_KEY,
            provider: mockDiaryProvider,
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
