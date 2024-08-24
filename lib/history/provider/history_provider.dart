import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/history/model/history_model.dart';
import 'package:greaticker/history/repository/history_repository.dart';

final historyProvider =
StateNotifierProvider<HistoryStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(HistoryRepositoryProvider);

  return HistoryStateNotifier(repository: repo);
});

class HistoryStateNotifier
    extends PaginationProvider<HistoryModel, HistoryRepository> {
  HistoryStateNotifier({
    required super.repository,
  });
}
