import 'package:json_annotation/json_annotation.dart';

part 'hall_of_fame_register_request_dto.g.dart';

@JsonSerializable()
class HallOfFameRegisterRequestDto {
  final bool? showAuthEmail;


  HallOfFameRegisterRequestDto({
    this.showAuthEmail,
  });

  Map<String, dynamic> toJson() => _$HallOfFameRegisterRequestDtoToJson(this);
}
