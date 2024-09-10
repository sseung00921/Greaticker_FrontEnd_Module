import 'package:json_annotation/json_annotation.dart';

part 'diary_model_request_dto.g.dart';

@JsonSerializable()
class DiaryModelRequestDto {
  final List<String> stickerInventory;

  DiaryModelRequestDto({
    required this.stickerInventory,
  });

  Map<String, dynamic> toJson() => _$DiaryModelRequestDtoToJson(this);
}
