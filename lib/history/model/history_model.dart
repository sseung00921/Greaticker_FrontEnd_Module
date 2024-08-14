
import 'package:greaticker/common/model/base_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel extends BaseModel implements IModelWithId   {
  final String id;
  final HistoryKind historyKind;
  final String projectName;
  final String? stickerName;
  final int dayInARow;

  HistoryModel({
    required this.id,
    required this.historyKind,
    required this.projectName,
    this.stickerName,
    required this.dayInARow,
    required super.createdDateTime,
    required super.updatedDateTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);
}
