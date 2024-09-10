
import 'package:greaticker/common/model/base_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hall_of_fame_post_api_response_model.g.dart';

@JsonSerializable()
class HallOfFamePostApiResponseModel  {
  final String hallOfFameId;


  HallOfFamePostApiResponseModel({
    required this.hallOfFameId,
  });

  factory HallOfFamePostApiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HallOfFamePostApiResponseModelFromJson(json);
}
