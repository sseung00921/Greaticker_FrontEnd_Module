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
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:greaticker/history/model/history_model.dart';


final MockHistoryRepositoryProvider = Provider<MockHistoryRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockHistoryRepository(dio, baseUrl: 'http://$ip/history');
  },
);

class MockHistoryRepository implements IBasePaginationRepository<HistoryModel> {
  MockHistoryRepository(Dio dio, {required String baseUrl});


  List<HistoryModel> mockData = List<HistoryModel>.generate(100, (index) {
    if (index % 5 == 0) {
      return HistoryModel(
        id: (index + 1).toString(),
        historyKind: HistoryKind.GET_STICKER,
        projectName: "앱 만들기",
        stickerId: "1",
        dayInARow: 8,
        createdDateTime: DateTime(2024, 8, 14),
        updatedDateTime: DateTime(2024, 8, 14),
      );
    } else if (index % 5 == 1) {
      return HistoryModel(
        id: (index + 1).toString(),
        historyKind: HistoryKind.START_GOAL,
        projectName: "앱 만들기",
        dayInARow: 3,
        createdDateTime: DateTime(2024, 8, 14),
        updatedDateTime: DateTime(2024, 8, 14),
      );
    } else if (index % 5 == 2) {
      return HistoryModel(
        id: (index + 1).toString(),
        historyKind: HistoryKind.ACCOMPLISH_GOAL,
        projectName: "앱 만들기",
        dayInARow: 10,
        createdDateTime: DateTime(2024, 8, 14),
        updatedDateTime: DateTime(2024, 8, 14),
      );
    } else if (index % 5 == 3) {
      return HistoryModel(
        id: (index + 1).toString(),
        historyKind: HistoryKind.RESET_GOAL,
        projectName: "앱 만들기",
        dayInARow: 17,
        createdDateTime: DateTime(2024, 8, 14),
        updatedDateTime: DateTime(2024, 8, 14),
      );
    } else if (index % 5 == 4) {
      return HistoryModel(
        id: (index + 1).toString(),
        historyKind: HistoryKind.DELETE_GOAL,
        projectName: "앱 만들기",
        dayInARow: 15,
        createdDateTime: DateTime(2024, 8, 14),
        updatedDateTime: DateTime(2024, 8, 14),
      );
    } else {
      return HistoryModel(
        id: (index + 1).toString(),
        historyKind: HistoryKind.GET_STICKER,
        projectName: "앱 만들기",
        stickerId: "1",
        dayInARow: 8,
        createdDateTime: DateTime(2024, 8, 14),
        updatedDateTime: DateTime(2024, 8, 14),
      );
    }
  });


  Future<ApiResponse<CursorPagination<HistoryModel>>> paginate ({PaginationParams? paginationParams = const PaginationParams()}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }

    CursorPaginationMeta mockMeta;
    if (paginationParams!.after == null || int.parse(paginationParams.after!) < 90) {
      mockMeta = CursorPaginationMeta(count: 10, hasMore: true);
    } else {
      mockMeta = CursorPaginationMeta(count: 10, hasMore: false);
    }

    List<HistoryModel> slicedMockData;
    if (paginationParams!.after == null) {
      slicedMockData = mockData.sublist(0, 10);
    } else {
      slicedMockData = mockData.sublist(
          int.parse(paginationParams.after!),
          int.parse(paginationParams.after!) + 10);
    }
    return ApiResponse(isSuccess: true, data: CursorPagination(meta: mockMeta, data: slicedMockData));
  }
}





