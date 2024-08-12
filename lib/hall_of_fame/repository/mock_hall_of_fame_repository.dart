import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/pagination_params.dart';
import 'package:greaticker/common/repository/base_pagination_repository.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:retrofit/retrofit.dart';


final MockHallOfFameRepositoryProvider = Provider<MockHallOfFameRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockHallOfFameRepository(dio, baseUrl: 'http://$ip/hall-of-fame');
  },
);

class MockHallOfFameRepository implements IBasePaginationRepository<HallOfFameModel> {
  MockHallOfFameRepository(Dio dio, {required String baseUrl});


  List<HallOfFameModel> mockData = List<HallOfFameModel>.generate(100, (index) {
    return HallOfFameModel(
      id: (index + 1).toString(),
      userNickName: '뾰롱이',
      likeCount: 123,
      accomplishedTopic: '간호조무사 시험 공부',
      userAuthId: 'abc${index}',
      createdDateTime: DateTime(2024, 8, 12),
      updatedDateTime: DateTime(2024, 8, 12),
    );
  });


  Future<CursorPagination<HallOfFameModel>> paginate ({PaginationParams? paginationParams = const PaginationParams()}) async {
    await Future.delayed(Duration(seconds: 1));

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
    return CursorPagination(meta: mockMeta, data: slicedMockData);
  }
}





