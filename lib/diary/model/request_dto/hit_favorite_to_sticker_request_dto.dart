import 'package:json_annotation/json_annotation.dart';

part 'hit_favorite_to_sticker_request_dto.g.dart';

@JsonSerializable()
class HitFavoriteToStickerRequestDto {
  final String stickerId;

  HitFavoriteToStickerRequestDto({
    required this.stickerId,
  });

  Map<String, dynamic> toJson() => _$HitFavoriteToStickerRequestDtoToJson(this);
}
