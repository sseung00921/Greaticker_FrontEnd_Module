import 'package:json_annotation/json_annotation.dart';

part 'hall_of_fame_register_request_dto.g.dart';

@JsonSerializable()
class HallOfFameRegisterRequestDto {
  final String projectId;
  final bool? showAuthId;


  HallOfFameRegisterRequestDto({
    required this.projectId,
    this.showAuthId,
  });

  Map<String, dynamic> toJson() => _$HallOfFameRegisterRequestDtoToJson(this);
}
