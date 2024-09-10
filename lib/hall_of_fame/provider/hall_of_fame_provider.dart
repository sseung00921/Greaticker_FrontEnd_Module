import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';
import 'package:greaticker/hall_of_fame/repository/hall_of_fame_repository.dart';
import 'package:greaticker/hall_of_fame/repository/mock_hall_of_fame_repository.dart';

final hallOfFameProvider =
StateNotifierProvider<HallOfFameStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(HallOfFameRepositoryProvider);
  final notifier = HallOfFameStateNotifier(repository: repo);

  ref.listen<ApiResponseBase>(hallOfFameApiResponseProvider, (previous, next) {
    if (next is ApiResponseLoading) {
      notifier.setLoadingState();
    } else if (next is ApiResponseError) {
      notifier.setErrorState();
    } else {
      notifier.paginate();

    };
  });

  return notifier;
});

class HallOfFameStateNotifier
    extends PaginationProvider<HallOfFameModel, HallOfFameRepository> {
  HallOfFameStateNotifier({
    required super.repository,
  });
}
