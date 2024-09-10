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

final MockHistoryRepositoryReturningErrorProvider = Provider<MockHistoryRepositoryReturningError>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockHistoryRepositoryReturningError(dio, baseUrl: 'http://$ip/history');
  },
);

class MockHistoryRepositoryReturningError implements IBasePaginationRepository<HistoryModel> {
  MockHistoryRepositoryReturningError(Dio dio, {required String baseUrl});


  Future<ApiResponse<CursorPagination<HistoryModel>>> paginate ({PaginationParams? paginationParams = const PaginationParams()}) async {
    throw Exception();
  }
}