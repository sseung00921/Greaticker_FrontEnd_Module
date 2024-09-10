import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';

import '../../repository/hall_of_fame/mock_hall_of_fame_repository.dart';
import '../../repository/hall_of_fame/mock_hall_of_fame_repository_returning_duplicated_hall_of_fame_error.dart';

final mockHallOfFameProviderReturningDuplicatedHallOfFameError =
StateNotifierProvider<MockHallOfFameStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(MockHallOfFameRepositoryReturningDuplicatedHallOfFameErrorProvider);

  return MockHallOfFameStateNotifier(repository: repo);
});

class MockHallOfFameStateNotifier
    extends PaginationProvider<HallOfFameModel, MockHallOfFameRepositoryReturningDuplicatedHallOfFameError> {


  MockHallOfFameStateNotifier({
    required super.repository,
  });
}
