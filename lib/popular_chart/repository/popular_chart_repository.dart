import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/pagination_params.dart';
import 'package:greaticker/common/repository/base_pagination_repository.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/popular_chart/model/popular_chart_model.dart';
import 'package:retrofit/retrofit.dart';

part 'popular_chart_repository.g.dart';

final PopularChartRepositoryProvider = Provider<PopularChartRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return PopularChartRepository(dio, baseUrl: 'http://$ip/popular-chart');
  },
);

// http://$ip/product
@RestApi()
abstract class PopularChartRepository implements IBasePaginationRepository<PopularChartModel> {
  factory PopularChartRepository(Dio dio, {String baseUrl}) = _PopularChartRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<PopularChartModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}

