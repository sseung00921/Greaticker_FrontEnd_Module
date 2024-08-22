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
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_request_dto.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hit_good_to_project_request_dto.dart';
import 'package:greaticker/hall_of_fame/repository/hall_of_fame_repository.dart';


final MockHallOfFameRepositoryReturningErrorProvider = Provider<MockHallOfFameRepositoryReturningError>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockHallOfFameRepositoryReturningError(dio, baseUrl: 'http://$ip/hall-of-fame');
  },
);

class MockHallOfFameRepositoryReturningError extends HallOfFameRepositoryBase implements IBasePaginationRepository<HallOfFameModel> {
  MockHallOfFameRepositoryReturningError(Dio dio, {required String baseUrl});


  Future<CursorPagination<HallOfFameModel>> paginate ({PaginationParams? paginationParams = const PaginationParams()}) async {
    throw Exception();
  }

  Future<ApiResponse<String>> registerHallOfFame({
    required HallOfFameRequestDto hallOfFameRequestDto,
  }) async {
    throw Exception();
  }

  Future<ApiResponse<String>> deleteHallOfFame({
    required HallOfFameRequestDto hallOfFameRequestDto,
  }) async {
    throw Exception();
  }

  Future<ApiResponse<String>> hitGoodToHallOfFame({
    required HitGoodToProjectRequestDto hitGoodToProjectRequestDto,
  }) async {
    throw Exception();
  }
}





