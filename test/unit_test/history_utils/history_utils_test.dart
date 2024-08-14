import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/exception/un_defined_history_content_exception.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:greaticker/history/utils/history_utils.dart';

void main() {
  group('historyContentMaker', () {
    test('returns correct message for getSticker', () {
      expect(
        HistoryUtils.historyContentMaker(
          historyKind: HistoryKind.getSticker,
          projectName: 'Fitness',
          stickerName: 'LittleWin',
          dayInARow: 5,
        ),
        'Fitness 목표 달성 5일 차 완료 스티커 "LittleWin"을 획득하셨습니다.',
      );
    });

    test('returns correct message for accomplishGoal', () {
      expect(
        HistoryUtils.historyContentMaker(
          historyKind: HistoryKind.accomplishGoal,
          projectName: 'Fitness',
        ),
        'Fitness 목표를 달성하셨습니다. 신규 목표를 시작하기 전까지는 모은 스티커들이 다이어리에 유지됩니다!',
      );
    });

    test('returns correct message for deleteGoal', () {
      expect(
        HistoryUtils.historyContentMaker(
          historyKind: HistoryKind.deleteGoal,
          projectName: 'Fitness',
        ),
        'Fitness 목표를 삭제하셨습니다. 새로운 목표를 생성해보세요!',
      );
    });

    test('returns correct message for startGoal', () {
      expect(
        HistoryUtils.historyContentMaker(
          historyKind: HistoryKind.startGoal,
          projectName: 'Fitness',
        ),
        '새로운 Fitness 목표를 시작하셨습니다! 30일 동안 잘 달성하시기를 응원합니다!',
      );
    });

    test('returns correct message for resetGoal', () {
      expect(
        HistoryUtils.historyContentMaker(
          historyKind: HistoryKind.resetGoal,
          projectName: 'Fitness',
          dayInARow: 7,
        ),
        'Fitness 7일차에 목표 달성을 체크하지 않아 다이어리가 초기화 되었습니다. 새로이 해당 목표를 1일차 부터 시작합니다.',
      );
    });

    test('throws exception for undefined history kind', () {
      expect(
            () => HistoryUtils.historyContentMaker(historyKind: null),
        throwsA(isA<UnDefinedHistoryKindException>()),
      );
    });
  });

  group('historyImageUrlSelector', () {
    test('returns correct URL for getSticker', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.getSticker,
          stickerName: 'LittleWin',
        ),
        'assets/img/diary/sticker/LittleWin_sticker.png',
      );
    });

    test('returns correct URL for accomplishGoal', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.accomplishGoal,
        ),
        'assets/img/history/accomplish_goal.png',
      );
    });

    test('returns correct URL for deleteGoal', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.deleteGoal,
        ),
        'assets/img/history/delete_goal.png',
      );
    });

    test('returns correct URL for startGoal', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.startGoal,
        ),
        'assets/img/history/start_goal.png',
      );
    });

    test('returns correct URL for resetGoal', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.resetGoal,
        ),
        'assets/img/history/reset_goal.png',
      );
    });

    test('throws exception for undefined history kind', () {
      expect(
            () => HistoryUtils.historyImageUrlSelector(historyKind: null),
        throwsA(isA<UnDefinedHistoryKindException>()),
      );
    });
  });
}