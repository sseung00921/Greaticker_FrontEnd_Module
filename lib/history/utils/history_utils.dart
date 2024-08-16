import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/exception/un_defined_history_content_exception.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';

class HistoryUtils {

  static String historyContentMaker(
      {HistoryKind? historyKind, String? projectName, String? stickerName, int? dayInARow}) {
    if (historyKind == HistoryKind.GET_STICKER) {
      if (dotenv.get(LANGUAGE) == "KO") {
        return "${projectName} 목표 달성 ${dayInARow}일 차 완료 스티커 \"${stickerName}\"을 획득하셨습니다.";
      } else if (dotenv.get(LANGUAGE) == "EN") {
        return "You've earned the \"${stickerName}\" sticker for completing the ${projectName} goal on day ${dayInARow} in a row.";
      } else {
        return "";
      }
    } else if (historyKind == HistoryKind.ACCOMPLISH_GOAL) {
      if (dotenv.get(LANGUAGE) == "KO") {
        return "${projectName} 목표를 달성하셨습니다. 신규 목표를 시작하기 전까지는 모은 스티커들이 다이어리에 유지됩니다!";
      } else if (dotenv.get(LANGUAGE) == "EN") {
        return "You've achieved the ${projectName} goal. Your collected stickers will remain in the diary until you start a new goal!";
      } else {
        return "";
      }
    } else if (historyKind == HistoryKind.DELETE_GOAL) {
      if (dotenv.get(LANGUAGE) == "KO") {
        return "${projectName} 목표를 삭제하셨습니다. 새로운 목표를 생성해보세요!";
      } else if (dotenv.get(LANGUAGE) == "EN") {
        return "You've deleted the ${projectName} goal. Create a new goal!";
      } else {
        return "";
      }
    } else if (historyKind == HistoryKind.START_GOAL) {
      if (dotenv.get(LANGUAGE) == "KO") {
        return "새로운 ${projectName} 목표를 시작하셨습니다! 30일 동안 잘 달성하시기를 응원합니다!";
      } else if (dotenv.get(LANGUAGE) == "EN") {
        return "You've started a new ${projectName} goal! Wishing you success over the next 30 days!";
      } else {
        return "";
      }
    } else if (historyKind == HistoryKind.RESET_GOAL) {
      if (dotenv.get(LANGUAGE) == "KO") {
        return "${projectName} ${dayInARow}일차에 목표 달성을 체크하지 않아 다이어리가 초기화 되었습니다. 새로이 해당 목표를 1일차 부터 시작합니다.";
      } else if (dotenv.get(LANGUAGE) == "EN") {
        return "You didn't check off your goal on day ${dayInARow} of the ${projectName} goal, so the diary has been reset. The goal will now restart from day 1.";
      } else {
        return "";
      }
    } else {
      throw UnDefinedHistoryKindException("undefined history kind");
    }
  }

  static String historyImageUrlSelector(
      {HistoryKind? historyKind, String? stickerName}) {
    if (historyKind == HistoryKind.GET_STICKER) {
      return "assets/img/diary/sticker/${stickerName}_sticker.png";
    } else if (historyKind == HistoryKind.ACCOMPLISH_GOAL) {
      return "assets/img/history/accomplish_goal.png";
    } else if (historyKind == HistoryKind.DELETE_GOAL) {
      return "assets/img/history/delete_goal.png";
    } else if (historyKind == HistoryKind.START_GOAL) {
      return "assets/img/history/start_goal.png";
    } else if (historyKind == HistoryKind.RESET_GOAL) {
      return "assets/img/history/reset_goal.png";
    } else {
      throw UnDefinedHistoryKindException("undefined history kind");
    }
  }

}

