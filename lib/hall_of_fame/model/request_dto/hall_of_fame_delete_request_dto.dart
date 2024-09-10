import 'package:json_annotation/json_annotation.dart';

part 'hall_of_fame_delete_request_dto.g.dart';

@JsonSerializable()
class HallOfFameDeleteRequestDto {
  final String hallOfFameId;


  HallOfFameDeleteRequestDto({
    required this.hallOfFameId,
  });

  Map<String, dynamic> toJson() => _$HallOfFameDeleteRequestDtoToJson(this);
}
