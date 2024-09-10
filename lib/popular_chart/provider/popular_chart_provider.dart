import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/repository/hall_of_fame_repository.dart';
import 'package:greaticker/hall_of_fame/repository/mock_hall_of_fame_repository.dart';
import 'package:greaticker/history/model/history_model.dart';
import 'package:greaticker/history/repository/mock_history_repository.dart';
import 'package:greaticker/popular_chart/model/popular_chart_model.dart';
import 'package:greaticker/popular_chart/repository/mock_popular_chart_repository.dart';
import 'package:greaticker/popular_chart/repository/popular_chart_repository.dart';

final popularChartProvider =
StateNotifierProvider<PopularChartStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(PopularChartRepositoryProvider);

  return PopularChartStateNotifier(repository: repo);
});

class PopularChartStateNotifier
    extends PaginationProvider<PopularChartModel, PopularChartRepository> {
  PopularChartStateNotifier({
    required super.repository,
  });
}
