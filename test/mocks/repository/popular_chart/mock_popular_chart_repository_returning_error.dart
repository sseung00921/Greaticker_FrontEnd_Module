import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/pagination_params.dart';
import 'package:greaticker/common/repository/base_pagination_repository.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:greaticker/history/model/history_model.dart';
import 'package:greaticker/popular_chart/model/popular_chart_model.dart';


final MockPopularChartRepositoryReturningErrorProvider = Provider<MockPopularChartRepositoryReturningError>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockPopularChartRepositoryReturningError(dio, baseUrl: 'http://$ip/popular-chart');
  },
);

class MockPopularChartRepositoryReturningError implements IBasePaginationRepository<PopularChartModel> {
  MockPopularChartRepositoryReturningError(Dio dio, {required String baseUrl});


  Future<CursorPagination<PopularChartModel>> paginate ({PaginationParams? paginationParams = const PaginationParams()}) async {
    throw Exception();
  }
}





