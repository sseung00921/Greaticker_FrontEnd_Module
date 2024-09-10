import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/exception/un_listed_sticker_number_exception.dart';
import 'package:greaticker/common/utils/url_builder_utils.dart';

void main() {
  group('UrlBuilderUtils', () {
    test('imageUrlBuilderByStickerName returns correct URL', () {
      final stickerName = "Littlewin";
      final result = UrlBuilderUtils.imageUrlBuilderByStickerName(stickerName);
      expect(result, equals("assets/img/diary/sticker/Littlewin_sticker.png"));
    });
  });

  test('imageUrlBuilderByStickerId throws custom error for invalid stickerId', () {
    expect(
          () => UrlBuilderUtils.imageUrlBuilderByStickerId('999'),
      throwsA(isA<UnListedStickerNumberException>()), // '!' 연산자가 적용된 부분이 null일 경우 TypeError가 발생
    );
  });
}
