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
    );

Map<String, dynamic> _$PopularChartModelToJson(PopularChartModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rank': instance.rank,
      'hitCnt': instance.hitCnt,
    };
