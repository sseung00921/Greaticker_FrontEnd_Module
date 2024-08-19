// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectRequestDto _$ProjectRequestDtoFromJson(Map<String, dynamic> json) =>
    ProjectRequestDto(
      projectId: json['projectId'] as String?,
      projectName: json['projectName'] as String?,
      prevProjectState:
          $enumDecode(_$ProjectStateKindEnumMap, json['prevProjectState']),
      nextProjectState:
          $enumDecode(_$ProjectStateKindEnumMap, json['nextProjectState']),
    );

Map<String, dynamic> _$ProjectRequestDtoToJson(ProjectRequestDto instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'prevProjectState': _$ProjectStateKindEnumMap[instance.prevProjectState]!,
      'nextProjectState': _$ProjectStateKindEnumMap[instance.nextProjectState]!,
    };

const _$ProjectStateKindEnumMap = {
  ProjectStateKind.NO_EXIST: 'NO_EXIST',
  ProjectStateKind.IN_PROGRESS: 'IN_PROGRESS',
  ProjectStateKind.COMPLETED: 'COMPLETED',
  ProjectStateKind.RESET: 'RESET',
};
