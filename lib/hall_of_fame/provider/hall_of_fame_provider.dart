import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/repository/hall_of_fame_repository.dart';
import 'package:greaticker/hall_of_fame/repository/mock_hall_of_fame_repository.dart';

final hallOfFameProvider =
StateNotifierProvider<HallOfFameStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(MockHallOfFameRepositoryProvider);

  return HallOfFameStateNotifier(repository: repo);
});

class HallOfFameStateNotifier
    extends PaginationProvider<HallOfFameModel, MockHallOfFameRepository> {
  HallOfFameStateNotifier({
    required super.repository,
  });
}
