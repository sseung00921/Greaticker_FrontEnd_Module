import 'package:json_annotation/json_annotation.dart';

part 'hit_good_to_project_request_dto.g.dart';

@JsonSerializable()
class HitGoodToProjectRequestDto {
  final String projectId;

  HitGoodToProjectRequestDto({
    required this.projectId,
  });

  Map<String, dynamic> toJson() => _$HitGoodToProjectRequestDtoToJson(this);
}
