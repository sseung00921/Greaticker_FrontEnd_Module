
import 'package:greaticker/common/model/base_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diary_model.g.dart';
abstract class DiaryModelBase {}

class DiaryModelError extends DiaryModelBase {
  final String message;

  DiaryModelError({
    required this.message,
  });
}

class DiaryModelLoading extends DiaryModelBase {}

@JsonSerializable()
class DiaryModel extends DiaryModelBase implements IModelWithId   {
  final String id;
  final List<String> stickerInventory;

  DiaryModel({
    required this.id,
    required this.stickerInventory,
  });

  factory DiaryModel.fromJson(Map<String, dynamic> json) =>
      _$DiaryModelFromJson(json);
}
