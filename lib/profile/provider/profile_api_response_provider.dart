import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:greaticker/profile/repository/mock_profile_repositry.dart';
import 'package:greaticker/profile/repository/profile_repository.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';

final profileApiResponseProvider =
StateNotifierProvider<ProfileApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProfileRepositoryProvider);
  final throttleManager = ref.read(throttleManagerProvider); // ThrottleManager 추가

  return ProfileApiResponseStateNotifier(repository: repo, throttleManager: throttleManager);
});

class ProfileApiResponseStateNotifier extends StateNotifier<ApiResponseBase> {
  final ProfileRepositoryBase repository;
  final ThrottleManager throttleManager; // ThrottleManager 필드 추가

  ProfileApiResponseStateNotifier({
    required this.repository,
    required this.throttleManager,
  }) : super(ApiResponseLoading());

  Future<ApiResponseBase?> changeNickname({
    required ChangeNicknameRequestDto changeNicknameRequestDto,
    required BuildContext context, // Context 추가
  }) async {
    return await throttleManager.executeWithModal("changeNickname", context, () async {
      try {
        state = ApiResponseLoading();
        final resp = await repository.changeNickname(
            changeNicknameRequestDto: changeNicknameRequestDto);
        state = resp;
        return state;
      } catch (e, stack) {
        print(e);
        print(stack);
        state = ApiResponseError(
            message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
        return state;
      }
    });
  }

  Future<ApiResponseBase?> logOut({
    required BuildContext context, // Context 추가
  }) async {
    return await throttleManager.executeWithModal("logOut", context, () async {
      try {
        state = ApiResponseLoading();
        final resp = await repository.logOut();
        state = resp;
        return state;
      } catch (e, stack) {
        print(e);
        print(stack);
        state = ApiResponseError(
            message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
        return state;
      }
    });
  }

  Future<ApiResponseBase?> deleteAccount({
    required BuildContext context, // Context 추가
  }) async {
    return await throttleManager.executeWithModal("deleteAccount", context, () async {
      try {
        state = ApiResponseLoading();
        final resp = await repository.deleteAccount();
        state = resp;
        return state;
      } catch (e, stack) {
        print(e);
        print(stack);
        state = ApiResponseError(
            message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
        return state;
      }
    });
  }
}
