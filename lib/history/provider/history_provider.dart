import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/repository/hall_of_fame_repository.dart';
import 'package:greaticker/hall_of_fame/repository/mock_hall_of_fame_repository.dart';
import 'package:greaticker/history/model/history_model.dart';
import 'package:greaticker/history/repository/mock_history_repository.dart';

final historyProvider =
StateNotifierProvider<HistoryStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(MockHistoryRepositoryProvider);

  return HistoryStateNotifier(repository: repo);
});

class HistoryStateNotifier
    extends PaginationProvider<HistoryModel, MockHistoryRepository> {
  HistoryStateNotifier({
    required super.repository,
  });
}
