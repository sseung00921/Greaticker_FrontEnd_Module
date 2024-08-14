
import 'package:greaticker/common/model/base_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_chart_model.g.dart';

@JsonSerializable()
class PopularChartModel extends BaseModel implements IModelWithId   {
  final String id;
  final int rank;
  final String stickerName;
  final String stickerDescription;
  final int hitCnt;

  PopularChartModel({
    required this.id,
    required this.rank,
    required this.stickerName,
    required this.stickerDescription,
    required this.hitCnt,
    required super.createdDateTime,
    required super.updatedDateTime,
  });

  factory PopularChartModel.fromJson(Map<String, dynamic> json) =>
      _$PopularChartModelFromJson(json);
}
