// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      id: json['id'] as String,
      historyKind: $enumDecode(_$HistoryKindEnumMap, json['historyKind']),
      projectName: json['projectName'] as String,
      stickerName: json['stickerName'] as String?,
      dayInARow: (json['dayInARow'] as num).toInt(),
      createdDateTime: DateTime.parse(json['createdDateTime'] as String),
      updatedDateTime: DateTime.parse(json['updatedDateTime'] as String),
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'createdDateTime': instance.createdDateTime.toIso8601String(),
      'updatedDateTime': instance.updatedDateTime.toIso8601String(),
      'id': instance.id,
      'historyKind': _$HistoryKindEnumMap[instance.historyKind]!,
      'projectName': instance.projectName,
      'stickerName': instance.stickerName,
      'dayInARow': instance.dayInARow,
    };

const _$HistoryKindEnumMap = {
  HistoryKind.GET_STICKER: 'GET_STICKER',
  HistoryKind.ACCOMPLISH_GOAL: 'ACCOMPLISH_GOAL',
  HistoryKind.DELETE_GOAL: 'DELETE_GOAL',
  HistoryKind.START_GOAL: 'START_GOAL',
  HistoryKind.RESET_GOAL: 'RESET_GOAL',
};
