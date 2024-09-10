import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hit_favorite_sticker_model.g.dart';

@JsonSerializable()
class HitFavoriteStickerModel {
  final String stickerId;

  HitFavoriteStickerModel({
    required this.stickerId
  });


  factory HitFavoriteStickerModel.fromJson(Map<String, dynamic> json) =>
      _$HitFavoriteStickerModelFromJson(json);
}
