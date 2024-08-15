
import 'package:greaticker/common/model/base_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sticker_model.g.dart';
abstract class StickerModelBase {}

class StickerModelError extends StickerModelBase {
  final String message;

  StickerModelError({
    required this.message,
  });
}

class StickerModelLoading extends StickerModelBase {}

@JsonSerializable()
class StickerModel extends StickerModelBase implements IModelWithId   {
  final String id;
  final String name;
  final String description;
  final int hitCnt;

  StickerModel({
    required this.id,
    required this.name,
    required this.description,
    required this.hitCnt,
  });

  factory StickerModel.fromJson(Map<String, dynamic> json) =>
      _$StickerModelFromJson(json);
}
