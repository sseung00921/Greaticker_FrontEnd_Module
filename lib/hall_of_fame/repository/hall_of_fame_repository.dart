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
abstract class HallOfFameRepository implements IBasePaginationRepository<HallOfFameModel> {
  factory HallOfFameRepository(Dio dio, {String baseUrl}) = _HallOfFameRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<HallOfFameModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @POST('/register-hall-of-fame')
  @Headers({'accessToken': 'true'})
  Future<ApiResponse<String>> registerHallOfFame({
    @Body() required HallOfFameRequestDto hallOfFameRequestDto,
  });

  @POST('/update-hall-of-fame')
  @Headers({'accessToken': 'true'})
  Future<ApiResponse<String>> reviseHallOfFamePrivacyPolice({
    @Body() required HallOfFameRequestDto hallOfFameRequestDto,
  });
}

