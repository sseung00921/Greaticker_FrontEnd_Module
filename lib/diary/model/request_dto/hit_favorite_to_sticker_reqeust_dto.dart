import 'package:json_annotation/json_annotation.dart';

part 'hit_favorite_to_sticker_reqeust_dto.g.dart';

@JsonSerializable()
class HitFavoriteToStickerReqeustDto {
  final String stickerId;

  HitFavoriteToStickerReqeustDto({
    required this.stickerId,
  });

  Map<String, dynamic> toJson() => _$HitFavoriteToStickerReqeustDtoToJson(this);
}