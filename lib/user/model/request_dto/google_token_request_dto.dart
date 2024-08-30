import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:json_annotation/json_annotation.dart';
/**
 * NO_EXIST -> IN_PROGRESS
 * IN_PROGRESS -> NO_EXIST
 * COMPLETED -> IN_PROGRESS
 * IN_PROGRESS -> COMPLETED
 * 위의 4가지 시나리오만 가능하다.
 **/

part 'google_token_request_dto.g.dart';

@JsonSerializable()
class GoogleTokenRequestDto {
  final String token;


  GoogleTokenRequestDto({
    required this.token,
  });

  Map<String, dynamic> toJson() => _$GoogleTokenRequestDtoToJson(this);
}
