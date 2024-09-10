import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/history/model/history_model.dart';
import 'package:greaticker/popular_chart/model/popular_chart_model.dart';

import '../../repository/history/mock_history_repository.dart';
import '../../repository/popular_chart/mock_popular_chart_repository.dart';
import '../../repository/popular_chart/mock_popular_chart_repository_returning_error.dart';

final mockPopularChartProviderReturningError =
StateNotifierProvider<MockPopularChartStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(MockPopularChartRepositoryReturningErrorProvider);

  return MockPopularChartStateNotifier(repository: repo);
});

class MockPopularChartStateNotifier
    extends PaginationProvider<PopularChartModel, MockPopularChartRepositoryReturningError> {


  MockPopularChartStateNotifier({
    required super.repository,
  });
}
