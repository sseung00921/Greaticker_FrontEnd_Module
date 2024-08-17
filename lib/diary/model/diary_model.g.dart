// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryModel _$DiaryModelFromJson(Map<String, dynamic> json) => DiaryModel(
      id: json['id'] as String,
      stickerInventory: (json['stickerInventory'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hitFavoriteList: (json['hitFavoriteList'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$DiaryModelToJson(DiaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stickerInventory': instance.stickerInventory,
      'hitFavoriteList': instance.hitFavoriteList.toList(),
    };
