// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularChartModel _$PopularChartModelFromJson(Map<String, dynamic> json) =>
    PopularChartModel(
      id: json['id'] as String,
      rank: (json['rank'] as num).toInt(),
      hitCnt: (json['hitCnt'] as num).toInt(),
      createdDateTime: DateTime.parse(json['createdDateTime'] as String),
      updatedDateTime: DateTime.parse(json['updatedDateTime'] as String),
    );

Map<String, dynamic> _$PopularChartModelToJson(PopularChartModel instance) =>
    <String, dynamic>{
      'createdDateTime': instance.createdDateTime.toIso8601String(),
      'updatedDateTime': instance.updatedDateTime.toIso8601String(),
      'id': instance.id,
      'rank': instance.rank,
      'hitCnt': instance.hitCnt,
    };
