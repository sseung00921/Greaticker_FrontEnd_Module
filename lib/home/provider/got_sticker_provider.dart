import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/repository/mock_project_repository.dart';
import 'package:greaticker/home/repository/project_repository.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';

final gotStickerProvider =
StateNotifierProvider<GotStickerStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryProvider);
  final throttleManager = ref.read(throttleManagerProvider); // ThrottleManager 추가

  return GotStickerStateNotifier(repository: repo, throttleManager: throttleManager);
});

class GotStickerStateNotifier extends StateNotifier<ApiResponseBase> {
  final ProjectRepositoryBase repository;
  final ThrottleManager throttleManager; // ThrottleManager 필드 추가

  GotStickerStateNotifier({
    required this.repository,
    required this.throttleManager,
  }) : super(ApiResponseLoading());

  Future<ApiResponseBase?> getGotStickerModel({required BuildContext context}) async {
    return await throttleManager.executeWithModal("getGotStickerModel", context, () async {
      try {
        state = ApiResponseLoading();
        final resp = await repository.getNewSticker();
        state = resp;
        return state;
      } catch (e, stack) {
        print(e);
        print(stack);
        state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
        return state;
      }
    });
  }
}
