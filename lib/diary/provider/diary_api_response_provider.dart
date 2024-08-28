import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/diary/model/request_dto/diary_model_request_dto.dart';
import 'package:greaticker/diary/model/request_dto/hit_favorite_to_sticker_reqeust_dto.dart';
import 'package:greaticker/diary/repository/diary_repository.dart';

final diaryApiResponseProvider =
    StateNotifierProvider<DiaryApiResponseStateNotifier, ApiResponseBase>(
        (ref) {
  final repo = ref.watch(DiaryRepositoryProvider);
  final throttleManager = ref.read(throttleManagerProvider);

  return DiaryApiResponseStateNotifier(
      repository: repo, throttleManager: throttleManager);
});

class DiaryApiResponseStateNotifier extends StateNotifier<ApiResponseBase> {
  final DiaryRepositoryBase repository;
  final ThrottleManager throttleManager;

  DiaryApiResponseStateNotifier(
      {required this.repository, required this.throttleManager})
      : super(ApiResponseLoading());

  Future<ApiResponseBase?> updateDiaryModel({
    required DiaryModelRequestDto diaryModelRequestDto,
    required BuildContext context,
  }) async {
    return await throttleManager.execute('updateDiaryModel', () async {
      try {
        state = ApiResponseLoading();
        final resp = await repository.updateDiaryModel(
            diaryModelRequestDto: diaryModelRequestDto);
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

  Future<ApiResponseBase?> hitFavoriteToSticker({
    required HitFavoriteToStickerReqeustDto hitFavoriteToStickerReqeustDto,
    required BuildContext context,
  }) async {
    return await throttleManager.executeWithModal(
      'hitFavoriteToSticker',
      context,
      () async {
        try {
          state = ApiResponseLoading();
          final resp = await repository.hitFavoriteToSticker(
              hitFavoriteToStickerReqeustDto: hitFavoriteToStickerReqeustDto);
          state = resp;
          return state;
        } catch (e, stack) {
          print(e);
          print(stack);
          state = ApiResponseError(
              message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
          return state;
        }
      },
    );
  }
}
