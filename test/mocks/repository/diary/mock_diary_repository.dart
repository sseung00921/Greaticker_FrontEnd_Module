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

final MockDiaryRepositoryProvider = Provider<MockDiaryRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return MockDiaryRepository(dio, baseUrl: 'http://$ip/diary');
  },
);

class MockDiaryRepository extends DiaryRepositoryBase {
  MockDiaryRepository(Dio dio, {required String baseUrl});

  DiaryModel mockData = DiaryModel(stickerInventory: [
    "1",
    "12",
    "21",
    "20",
    "8",
    "11",
    "24",
    "16",
    "3",
    "7",
    "14",
    "4",
    "10",
    "9",
    "19",
    "2",
    "22",
    "23",
    "15",
    "5",
    "18",
    "13",
    "6",
    "17"
  ], hitFavoriteList: {
    "1",
    "12",
    "20"
  });

  Future<ApiResponse<DiaryModel>> getDiaryModel() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return ApiResponse(isSuccess: true, data: mockData);
  }

  @override
  Future<ApiResponse<String>> updateDiaryModel({required DiaryModelRequestDto diaryModelRequestDto}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return ApiResponse(isSuccess: true,);
  }

  @override
  Future<ApiResponse<String>> hitFavoriteToSticker({required HitFavoriteToStickerReqeustDto hitFavoriteToStickerReqeustDto}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return ApiResponse(isSuccess: true,);
  }
}
