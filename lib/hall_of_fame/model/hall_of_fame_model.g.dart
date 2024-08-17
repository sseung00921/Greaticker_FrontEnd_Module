// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall_of_fame_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HallOfFameModel _$HallOfFameModelFromJson(Map<String, dynamic> json) =>
    HallOfFameModel(
      id: json['id'] as String,
      userNickName: json['userNickName'] as String,
      accomplishedGoal: json['accomplishedGoal'] as String?,
      userAuthId: json['userAuthId'] as String?,
      likeCount: (json['likeCount'] as num).toInt(),
      createdDateTime: DateTime.parse(json['createdDateTime'] as String),
      updatedDateTime: DateTime.parse(json['updatedDateTime'] as String),
    );

Map<String, dynamic> _$HallOfFameModelToJson(HallOfFameModel instance) =>
    <String, dynamic>{
      'createdDateTime': instance.createdDateTime.toIso8601String(),
      'updatedDateTime': instance.updatedDateTime.toIso8601String(),
      'id': instance.id,
      'userNickName': instance.userNickName,
      'accomplishedGoal': instance.accomplishedGoal,
      'userAuthId': instance.userAuthId,
      'likeCount': instance.likeCount,
    };
