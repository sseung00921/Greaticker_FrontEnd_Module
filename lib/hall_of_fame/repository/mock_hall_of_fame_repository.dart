import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/pagination_params.dart';
import 'package:greaticker/common/repository/base_pagination_repository.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_post_api_response_model.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_delete_request_dto.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_register_request_dto.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hit_good_to_hall_of_fame_request_dto.dart';
import 'package:greaticker/hall_of_fame/repository/hall_of_fame_repository.dart';


final MockHallOfFameRepositoryProvider = Provider<MockHallOfFameRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockHallOfFameRepository(dio, baseUrl: 'http://$ip/hall-of-fame');
  },
);

class MockHallOfFameRepository extends HallOfFameRepositoryBase implements IBasePaginationRepository<HallOfFameModel> {
  MockHallOfFameRepository(Dio dio, {required String baseUrl});

  List<HallOfFameModel> mockData = List<HallOfFameModel>.generate(100, (index) {
    if (index == 3 || index == 6) {
      return HallOfFameModel(
        id: (index + 1).toString(),
        userNickName: '뾰롱이',
        likeCount: 123,
        accomplishedGoal: '간호조무사 시험 공부',
        userAuthId: 'abc${index}',
        createdDateTime: DateTime(2024, 8, 12),
        updatedDateTime: DateTime(2024, 8, 12),
        isWrittenByMe: true,
        isHitGoodByMe: false,
      );
    } else if (index == 2 || index == 5){
      return HallOfFameModel(
        id: (index + 1).toString(),
        userNickName: '뾰롱이',
        likeCount: 123,
        accomplishedGoal: '간호조무사 시험 공부',
        userAuthId: 'abc${index}',
        createdDateTime: DateTime(2024, 8, 12),
        updatedDateTime: DateTime(2024, 8, 12),
        isWrittenByMe: false,
        isHitGoodByMe: true,
      );
    } else {
      return HallOfFameModel(
        id: (index + 1).toString(),
        userNickName: '뾰롱이',
        likeCount: 123,
        accomplishedGoal: '간호조무사 시험 공부',
        userAuthId: 'abc${index}',
        createdDateTime: DateTime(2024, 8, 12),
        updatedDateTime: DateTime(2024, 8, 12),
        isWrittenByMe: false,
        isHitGoodByMe: false,
      );
    }
  });


  Future<ApiResponse<CursorPagination<HallOfFameModel>>> paginate ({PaginationParams? paginationParams = const PaginationParams()}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    CursorPaginationMeta mockMeta;
    if (paginationParams!.after == null || int.parse(paginationParams.after!) < 90) {
      mockMeta = CursorPaginationMeta(count: 10, hasMore: true);
    } else {
      mockMeta = CursorPaginationMeta(count: 10, hasMore: false);
    }

    List<HallOfFameModel> slicedMockData;
    if (paginationParams!.after == null) {
      slicedMockData = mockData.sublist(0, 10);
    } else {
      slicedMockData = mockData.sublist(
          int.parse(paginationParams.after!),
          int.parse(paginationParams.after!) + 10);
    }
    return ApiResponse(isSuccess: true, data: CursorPagination(meta: mockMeta, data: slicedMockData));
  }

  Future<ApiResponse<HallOfFamePostApiResponseModel>> registerHallOfFame({
    required HallOfFameRegisterRequestDto hallOfFameRequestDto,
  }) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }

    return ApiResponse(isSuccess: true);
  }

  Future<ApiResponse<HallOfFamePostApiResponseModel>> deleteHallOfFame({
    required HallOfFameDeleteRequestDto hallOfFameRequestDto,
  }) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }

    return ApiResponse(isSuccess: true);
  }

  Future<ApiResponse<HallOfFamePostApiResponseModel>> hitGoodToHallOfFame({
    required HitGoodToHallOfFametRequestDto hitGoodToProjectRequestDto,
  }) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }

    return ApiResponse(isSuccess: true);
  }
}





