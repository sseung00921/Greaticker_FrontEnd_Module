import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/exception/un_defined_history_content_exception.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:greaticker/history/utils/history_utils.dart';

void main() {
  test('throws exception for undefined history kind', () {
    expect(
          () => HistoryUtils.historyContentMaker(historyKind: null),
      throwsA(isA<UnDefinedHistoryKindException>()),
    );
  });

  group('historyImageUrlSelector', () {
    test('returns correct URL for getSticker', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.GET_STICKER,
          stickerName: 'Littlewin',
        ),
        'assets/img/diary/sticker/Littlewin_sticker.png',
      );
    });

    test('returns correct URL for accomplishGoal', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.ACCOMPLISH_GOAL,
        ),
        'assets/img/history/accomplish_goal.png',
      );
    });

    test('returns correct URL for deleteGoal', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.DELETE_GOAL,
        ),
        'assets/img/history/delete_goal.png',
      );
    });

    test('returns correct URL for startGoal', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.START_GOAL,
        ),
        'assets/img/history/start_goal.png',
      );
    });

    test('returns correct URL for resetGoal', () {
      expect(
        HistoryUtils.historyImageUrlSelector(
          historyKind: HistoryKind.RESET_GOAL,
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