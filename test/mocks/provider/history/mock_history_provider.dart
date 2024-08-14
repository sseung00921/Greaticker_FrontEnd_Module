import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/history/model/history_model.dart';

import '../../repository/history/mock_history_repository.dart';

final mockHistoryProvider =
StateNotifierProvider<MockHistoryStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(MockHistoryRepositoryProvider);

  return MockHistoryStateNotifier(repository: repo);
});

class MockHistoryStateNotifier
    extends PaginationProvider<HistoryModel, MockHistoryRepository> {


  MockHistoryStateNotifier({
    required super.repository,
  });
}
