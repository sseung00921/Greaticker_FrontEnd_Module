import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/pagination_params.dart';
import 'package:greaticker/common/repository/base_pagination_repository.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:retrofit/retrofit.dart';

part 'history_repository.g.dart';

final HistoryRepositoryProvider = Provider<HistoryRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return HistoryRepository(dio, baseUrl: 'http://$ip/history');
  },
);

// http://$ip/product
@RestApi()
abstract class HistoryRepository implements IBasePaginationRepository<HallOfFameModel> {
  factory HistoryRepository(Dio dio, {String baseUrl}) = _HistoryRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<HallOfFameModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}

