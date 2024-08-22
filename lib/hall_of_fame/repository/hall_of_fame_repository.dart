import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/pagination_params.dart';
import 'package:greaticker/common/repository/base_pagination_repository.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_request_dto.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hit_good_to_project_request_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'hall_of_fame_repository.g.dart';

final HallOfFameRepositoryProvider = Provider<HallOfFameRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return HallOfFameRepository(dio, baseUrl: 'http://$ip/hall-of-fame');
  },
);

// http://$ip/product
@RestApi()
abstract class HallOfFameRepository extends HallOfFameRepositoryBase
    implements IBasePaginationRepository<HallOfFameModel> {
  factory HallOfFameRepository(Dio dio, {String baseUrl}) =
      _HallOfFameRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<HallOfFameModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @POST('/register')
  @Headers({'accessToken': 'true'})
  Future<ApiResponse<String>> registerHallOfFame({
    @Body() required HallOfFameRequestDto hallOfFameRequestDto,
  });

  @POST('/delete')
  @Headers({'accessToken': 'true'})
  Future<ApiResponse<String>> deleteHallOfFame({
    @Body() required HallOfFameRequestDto hallOfFameRequestDto,
  });

  @POST('/hit-good')
  @Headers({'accessToken': 'true'})
  Future<ApiResponse<String>> hitGoodToHallOfFame({
    @Body() required HitGoodToProjectRequestDto hitGoodToProjectRequestDto,
  });
}

abstract class HallOfFameRepositoryBase {
  Future<CursorPagination<HallOfFameModel>> paginate({
    PaginationParams paginationParams,
  });

  Future<ApiResponse<String>> registerHallOfFame({
    required HallOfFameRequestDto hallOfFameRequestDto,
  });

  Future<ApiResponse<String>> deleteHallOfFame({
    required HallOfFameRequestDto hallOfFameRequestDto,
  });

  Future<ApiResponse<String>> hitGoodToHallOfFame({
    required HitGoodToProjectRequestDto hitGoodToProjectRequestDto,
  });
}
