import 'package:greaticker/common/exception/un_defined_history_content_exception.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';

class HistoryUtils {

  static String historyContentMaker(
      {HistoryKind? historyKind, String? projectName, String? stickerName, int? dayInARow}) {
    if (historyKind == HistoryKind.getSticker) {
      return "${projectName} 목표 달성 ${dayInARow}일 차 완료 스티커 \"${stickerName}\"을 획득하셨습니다.";
    } else if (historyKind == HistoryKind.accomplishGoal) {
      return "${projectName} 목표를 달성하셨습니다. 신규 목표를 시작하기 전까지는 모은 스티커들이 다이어리에 유지됩니다!";
    } else if (historyKind == HistoryKind.deleteGoal) {
      return "${projectName} 목표를 삭제하셨습니다. 새로운 목표를 생성해보세요!";
    } else if (historyKind == HistoryKind.startGoal) {
      return "새로운 ${projectName} 목표를 시작하셨습니다! 30일 동안 잘 달성하시기를 응원합니다!";
    } else if (historyKind == HistoryKind.resetGoal) {
      return "${projectName} ${dayInARow}일차에 목표 달성을 체크하지 않아 다이어리가 초기화 되었습니다. 새로이 해당 목표를 1일차 부터 시작합니다.";
    } else {
      throw UnDefinedHistoryKindException("undefined history kind");
    }
  }

  static String historyImageUrlSelector(
      {HistoryKind? historyKind, String? stickerName}) {
    if (historyKind == HistoryKind.getSticker) {
      return "assets/img/diary/sticker/${stickerName}_sticker.png";
    } else if (historyKind == HistoryKind.accomplishGoal) {
      return "assets/img/history/accomplish_goal.png";
    } else if (historyKind == HistoryKind.deleteGoal) {
      return "assets/img/history/delete_goal.png";
    } else if (historyKind == HistoryKind.startGoal) {
      return "assets/img/history/start_goal.png";
    } else if (historyKind == HistoryKind.resetGoal) {
      return "assets/img/history/reset_goal.png";
    } else {
      throw UnDefinedHistoryKindException("undefined history kind");
    }
  }

}

