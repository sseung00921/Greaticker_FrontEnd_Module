import 'package:json_annotation/json_annotation.dart';

part 'change_nickname_result_model.g.dart';

@JsonSerializable()
class ChangeNicknameResultModel {
  final String newUserNickname;

  ChangeNicknameResultModel({
    required this.newUserNickname,
  });


  factory ChangeNicknameResultModel.fromJson(Map<String, dynamic> json) =>
      _$ChangeNicknameResultModelFromJson(json);
}
