import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:json_annotation/json_annotation.dart';
/**
 * NO_EXIST -> IN_PROGRESS
 * IN_PROGRESS -> NO_EXIST
 * COMPLETED -> IN_PROGRESS
 * IN_PROGRESS -> COMPLETED
 * 위의 4가지 시나리오만 가능하다.
 **/

part 'project_request_dto.g.dart';

@JsonSerializable()
class ProjectRequestDto {
  final String? projectId;
  final String? projectName;
  final ProjectStateKind prevProjectState;
  final ProjectStateKind nextProjectState;


  ProjectRequestDto({
    this.projectId,
    this.projectName,
    required this.prevProjectState,
    required this.nextProjectState,
  });

  Map<String, dynamic> toJson() => _$ProjectRequestDtoToJson(this);
}
