
import 'package:greaticker/common/model/base_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_chart_model.g.dart';

@JsonSerializable()
class PopularChartModel implements IModelWithId   {
  final String id;
  final int rank;
  final int hitCnt;

  PopularChartModel({
    required this.id,
    required this.rank,
    required this.hitCnt,
  });

  factory PopularChartModel.fromJson(Map<String, dynamic> json) =>
      _$PopularChartModelFromJson(json);
}
