
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
  final String? userAuthEmail;
  // 좋아요 횟수
  final int likeCount;
  // 내가 작성한 명전 카드인지 여부
  final bool isWrittenByMe;
  final bool isHitGoodByMe;

  HallOfFameModel({
    required this.id,
    required this.userNickName,
    this.accomplishedGoal,
    this.userAuthEmail,
    required this.likeCount,
    required this.isWrittenByMe,
    required this.isHitGoodByMe,
    required super.createdDateTime,
    required super.updatedDateTime,
  });

  factory HallOfFameModel.fromJson(Map<String, dynamic> json) =>
      _$HallOfFameModelFromJson(json);
}
