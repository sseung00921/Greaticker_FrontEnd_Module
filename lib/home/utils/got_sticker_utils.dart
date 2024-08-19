import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/home/model/project_model.dart';

class GotStickerUtils {
  static String gotStickerComment(ProjectModel projectState, String stickerName) {
    if (dotenv.get(LANGUAGE) == "KO") {
      return "${projectState.dayInARow}일차 목표 달성 보상 ${stickerName} 스티커를 획득하셨습니다!";
    } else if (dotenv.get(LANGUAGE) == "EN") {
      return "The reward for achieving your goal on day ${projectState.dayInARow}: You've earned the ${stickerName} sticker!";
    } else {
      return "";
    }
  }
}