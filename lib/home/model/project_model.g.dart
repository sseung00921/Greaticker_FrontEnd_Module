// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
      projectStateKind:
          $enumDecode(_$ProjectStateKindEnumMap, json['projectStateKind']),
      projectName: json['projectName'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      dayInARow: (json['dayInARow'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'projectStateKind': _$ProjectStateKindEnumMap[instance.projectStateKind]!,
      'projectName': instance.projectName,
      'startDate': instance.startDate?.toIso8601String(),
      'dayInARow': instance.dayInARow,
    };

const _$ProjectStateKindEnumMap = {
  ProjectStateKind.NO_EXIST: 'NO_EXIST',
  ProjectStateKind.IN_PROGRESS: 'IN_PROGRESS',
  ProjectStateKind.COMPLETED: 'COMPLETED',
  ProjectStateKind.RESET: 'RESET',
};
