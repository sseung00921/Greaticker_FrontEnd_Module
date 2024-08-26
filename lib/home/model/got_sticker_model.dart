import 'package:greaticker/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'got_sticker_model.g.dart';

@JsonSerializable()
class GotStickerModel implements IModelWithId   {
  final String id;
  final bool isAlreadyGotTodaySticker;

  GotStickerModel({
    required this.id,
    required this.isAlreadyGotTodaySticker
  });

  factory GotStickerModel.fromJson(Map<String, dynamic> json) =>
      _$GotStickerModelFromJson(json);
}