import 'package:json_annotation/json_annotation.dart';

part 'hit_good_to_hall_of_fame_request_dto.g.dart';

@JsonSerializable()
class HitGoodToHallOfFametRequestDto {
  final String hallOfFameId;

  HitGoodToHallOfFametRequestDto({
    required this.hallOfFameId,
  });

  Map<String, dynamic> toJson() => _$HitGoodToHallOfFametRequestDtoToJson(this);
}
