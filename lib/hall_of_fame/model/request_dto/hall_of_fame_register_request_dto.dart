import 'package:json_annotation/json_annotation.dart';

part 'hall_of_fame_register_request_dto.g.dart';

@JsonSerializable()
class HallOfFameRegisterRequestDto {
  final String projectId;
  final bool? showAuthEmail;


  HallOfFameRegisterRequestDto({
    required this.projectId,
    this.showAuthEmail,
  });

  Map<String, dynamic> toJson() => _$HallOfFameRegisterRequestDtoToJson(this);
}
