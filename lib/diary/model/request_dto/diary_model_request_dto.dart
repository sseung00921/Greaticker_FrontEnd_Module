import 'package:json_annotation/json_annotation.dart';

part 'diary_model_request_dto.g.dart';

@JsonSerializable()
class DiaryModelRequestDto {
  final String id;
  final List<String> stickerInventory;
  final Set<String> hitFavoriteList;

  DiaryModelRequestDto({
    required this.id,
    required this.stickerInventory,
    required this.hitFavoriteList,
  });

  Map<String, dynamic> toJson() => _$DiaryModelRequestDtoToJson(this);
}
