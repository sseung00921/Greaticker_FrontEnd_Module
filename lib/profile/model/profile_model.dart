import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

abstract class ProfileModelBase {}

class ProfileModelError extends ProfileModelBase {
  final String message;

  ProfileModelError({
    required this.message,
  });
}

class ProfileModelLoading extends ProfileModelBase {}

@JsonSerializable()
class ProfileModel extends ProfileModelBase {
  final String userNickname;

  ProfileModel({
    required this.userNickname,
  });


  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
