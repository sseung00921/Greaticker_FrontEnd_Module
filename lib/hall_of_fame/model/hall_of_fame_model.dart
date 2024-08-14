
import 'package:greaticker/common/model/base_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hall_of_fame_model.g.dart';

@JsonSerializable()
class HallOfFameModel extends BaseModel implements IModelWithId   {
  final String id;
  // 유저 닉네임
  final String userNickName;
  // 달성한 목표
  final String? accomplishedGoal;
  // 유저 auth ID
  final String? userAuthId;
  // 좋아요 횟수
  final int likeCount;

  HallOfFameModel({
    required this.id,
    required this.userNickName,
    this.accomplishedGoal,
    this.userAuthId,
    required this.likeCount,
    required super.createdDateTime,
    required super.updatedDateTime,
  });

  factory HallOfFameModel.fromJson(Map<String, dynamic> json) =>
      _$HallOfFameModelFromJson(json);
}
