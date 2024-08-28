
import 'package:greaticker/common/model/base_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

part 'diary_model.g.dart';

@JsonSerializable()
class DiaryModel {
  final List<String> stickerInventory;
  final Set<String> hitFavoriteList;

  DiaryModel({
    required this.stickerInventory,
    required this.hitFavoriteList,
  });

  factory DiaryModel.fromJson(Map<String, dynamic> json) =>
      _$DiaryModelFromJson(json);

}
