import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/model/request_dto/diary_model_request_dto.dart';
import 'package:greaticker/diary/model/request_dto/hit_favorite_to_sticker_reqeust_dto.dart';
import 'package:greaticker/diary/repository/diary_repository.dart';
import 'package:greaticker/diary/model/hit_favorite_sticker_model.dart';

final MockDiaryRepositoryReturningErrorProvider = Provider<MockDiaryRepositoryReturingError>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return MockDiaryRepositoryReturingError(dio, baseUrl: 'http://$ip/diary');
  },
);

class MockDiaryRepositoryReturingError extends DiaryRepositoryBase{
  MockDiaryRepositoryReturingError(Dio dio, {required String baseUrl});

  Future<ApiResponse<DiaryModel>> getDiaryModel() async {
    throw Exception();
  }

  @override
  Future<ApiResponse<String>> updateDiaryModel({required DiaryModelRequestDto diaryModelRequestDto}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return ApiResponse(isSuccess: true,);
  }

  @override
  Future<ApiResponse<HitFavoriteStickerModel>> hitFavoriteToSticker({required HitFavoriteToStickerReqeustDto hitFavoriteToStickerReqeustDto}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return ApiResponse(isSuccess: true,);
  }
}
