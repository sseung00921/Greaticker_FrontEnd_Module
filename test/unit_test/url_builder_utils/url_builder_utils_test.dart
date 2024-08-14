import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/utils/url_builder_utils.dart';

void main() {
  group('UrlBuilderUtils', () {
    test('imageUrlBuilderByStickerName returns correct URL', () {
      final stickerName = "LittleWin";
      final result = UrlBuilderUtils.imageUrlBuilderByStickerName(stickerName);
      expect(result, equals("assets/img/diary/sticker/LittleWin_sticker.png"));
    });
  });
}
