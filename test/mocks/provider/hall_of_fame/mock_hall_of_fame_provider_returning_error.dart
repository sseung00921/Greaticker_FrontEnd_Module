import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';

import '../../repository/hall_of_fame/mock_hall_of_fame_repository.dart';
import '../../repository/hall_of_fame/mock_hall_of_fame_repository_returning_error.dart';

final mockHallOfFameProviderReturningError =
StateNotifierProvider<MockHallOfFameStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(MockHallOfFameRepositoryReturningErrorProvider);

  return MockHallOfFameStateNotifier(repository: repo);
});

class MockHallOfFameStateNotifier
    extends PaginationProvider<HallOfFameModel, MockHallOfFameRepositoryReturningError> {


  MockHallOfFameStateNotifier({
    required super.repository,
  });
}
