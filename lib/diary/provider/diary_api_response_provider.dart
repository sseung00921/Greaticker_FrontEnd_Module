import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/model/request_dto/hit_favorite_to_sticker_request_dto.dart';
import 'package:greaticker/diary/repository/mock_diary_repository.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_request_dto.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hit_good_to_project_request_dto.dart';

final diaryApiResponseProvider =
StateNotifierProvider<DiaryApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockDiaryRepositoryProvider);

  return DiaryApiResponseStateNotifier(repository: repo);
});

class DiaryApiResponseStateNotifier extends StateNotifier<ApiResponseBase> {

  final MockDiaryRepository repository;

  DiaryApiResponseStateNotifier({required this.repository}) : super(ApiResponseLoading());


  Future<void> hitFavoriteSticker({required HitFavoriteToStickerRequestDto hitFavoriteToStickerRequestDto}) async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.hitFavoriteSticker(hitFavoriteToStickerRequestDto: hitFavoriteToStickerRequestDto);
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }
}