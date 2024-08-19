import 'package:greaticker/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'got_sticker_model.g.dart';
abstract class GotStickerModelBase {}

class GotStickerModelError extends GotStickerModelBase {
  final String message;

  GotStickerModelError({
    required this.message,
  });
}

class GotStickerModelLoading extends GotStickerModelBase {}

@JsonSerializable()
class GotStickerModel extends GotStickerModelBase implements IModelWithId   {
  final String id;
  final bool isAlreadyGotTodaySticker;

  GotStickerModel({
    required this.id,
    required this.isAlreadyGotTodaySticker
  });

  factory GotStickerModel.fromJson(Map<String, dynamic> json) =>
      _$GotStickerModelFromJson(json);
}