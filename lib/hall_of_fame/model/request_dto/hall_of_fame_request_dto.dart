import 'package:json_annotation/json_annotation.dart';

part 'hall_of_fame_request_dto.g.dart';

@JsonSerializable()
class HallOfFameRequestDto {
  final String projectId;
  final bool? showAuthId;
  final bool? showGoal;


  HallOfFameRequestDto({
    required this.projectId,
    this.showAuthId,
    this.showGoal,
  });

  Map<String, dynamic> toJson() => _$HallOfFameRequestDtoToJson(this);
}
