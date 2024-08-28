import 'package:greaticker/common/constants/language/stickers.dart';
import 'package:greaticker/common/exception/un_listed_sticker_number_exception.dart';

class UrlBuilderUtils {
  static String imageUrlBuilderByStickerName(String stickerName) {
    return "assets/img/diary/sticker/${stickerName}_sticker.png";
  }

  static String imageUrlBuilderByStickerId(String stickerId) {
    if (!STICKER_ID_NAME_MAPPER.containsKey(stickerId)) {
      print(stickerId);
      throw UnListedStickerNumberException("unListed sticker number");
    }
    String stickerName = STICKER_ID_NAME_MAPPER[stickerId]!;
    return "assets/img/diary/sticker/${stickerName}_sticker.png";
  }
}