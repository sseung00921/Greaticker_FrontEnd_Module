import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_request_dto.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hit_good_to_project_request_dto.dart';
import 'package:greaticker/hall_of_fame/repository/hall_of_fame_repository.dart';
import 'package:greaticker/hall_of_fame/repository/mock_hall_of_fame_repository.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:greaticker/profile/repository/mock_profile_repositry.dart';
import 'package:greaticker/profile/repository/profile_repository.dart';

final hallOfFameApiResponseProvider =
    StateNotifierProvider<HallOfFameApiResponseStateNotifier, ApiResponseBase>(
        (ref) {
  final repo = ref.watch(MockHallOfFameRepositoryProvider);
  final throttleManager = ref.read(throttleManagerProvider);

  return HallOfFameApiResponseStateNotifier(
      repository: repo, throttleManager: throttleManager);
});

class HallOfFameApiResponseStateNotifier
    extends StateNotifier<ApiResponseBase> {
  final HallOfFameRepositoryBase repository;
  final ThrottleManager throttleManager;

  HallOfFameApiResponseStateNotifier(
      {required this.repository, required this.throttleManager})
      : super(ApiResponseLoading());

  Future<ApiResponseBase?> registerHallOfFame({
    required HallOfFameRequestDto hallOfFameRequestDto,
    required BuildContext context,
  }) async {
    return await throttleManager.executeWithModal("registerHallOfFame", context,
        () async {
      try {
        state = ApiResponseLoading();
        final resp = await repository.registerHallOfFame(
            hallOfFameRequestDto: hallOfFameRequestDto);
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

  Future<ApiResponseBase?> deleteHallOfFame({
    required HallOfFameRequestDto hallOfFameRequestDto,
    required BuildContext context,
  }) async {
    return await throttleManager.executeWithModal("deleteHallOfFame", context,
        () async {
      try {
        state = ApiResponseLoading();
        final resp = await repository.deleteHallOfFame(
            hallOfFameRequestDto: hallOfFameRequestDto);
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

  Future<ApiResponseBase?> hitGoodToHallOfFame({
    required HitGoodToProjectRequestDto hitGoodToProjectRequestDto,
    required BuildContext context,
  }) async {
    return await throttleManager
        .executeWithModal("hitGoodToHallOfFame", context, () async {
      try {
        state = ApiResponseLoading();
        final resp = await repository.hitGoodToHallOfFame(
            hitGoodToProjectRequestDto: hitGoodToProjectRequestDto);
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
