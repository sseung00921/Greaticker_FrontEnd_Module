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
import 'package:greaticker/popular_chart/model/popular_chart_model.dart';


final MockPopularChartRepositoryProvider = Provider<MockPopularChartRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockPopularChartRepository(dio, baseUrl: 'http://$ip/popular-chart');
  },
);

class MockPopularChartRepository implements IBasePaginationRepository<PopularChartModel> {
  MockPopularChartRepository(Dio dio, {required String baseUrl});


  List<PopularChartModel> mockData = List<PopularChartModel>.generate(24, (index) {
      return PopularChartModel(
        id: (index + 1).toString(),
        rank: index + 1,
        hitCnt: 123,
      );
    });


  Future<ApiResponse<CursorPagination<PopularChartModel>>> paginate ({PaginationParams? paginationParams = const PaginationParams()}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }

    CursorPaginationMeta mockMeta = CursorPaginationMeta(count: 30, hasMore: false);

    List<PopularChartModel> MockData = mockData;

    return ApiResponse(isSuccess: true, data: CursorPagination(meta: mockMeta, data: mockData));
  }
}





