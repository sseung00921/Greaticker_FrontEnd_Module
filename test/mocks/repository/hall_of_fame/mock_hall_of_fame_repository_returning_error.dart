import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/pagination_params.dart';
import 'package:greaticker/common/repository/base_pagination_repository.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';



final MockHallOfFameRepositoryReturningErrorProvider = Provider<MockHallOfFameRepositoryReturningError>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockHallOfFameRepositoryReturningError(dio, baseUrl: 'http://$ip/hall-of-fame');
  },
);

class MockHallOfFameRepositoryReturningError implements IBasePaginationRepository<HallOfFameModel> {
  MockHallOfFameRepositoryReturningError(Dio dio, {required String baseUrl});

  Future<CursorPagination<HallOfFameModel>> paginate ({PaginationParams? paginationParams = const PaginationParams()}) async {
    throw Exception();
  }
}





