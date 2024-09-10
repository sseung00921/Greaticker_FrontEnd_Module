
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';

import '../../../repository/hall_of_fame/mock_hall_of_fame_repository.dart';

final mockHallOfFameApiResponseProvider =
StateNotifierProvider<HallOfFameApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockHallOfFameRepositoryProvider);
  final throttleManager = ref.watch(throttleManagerProvider);

  return HallOfFameApiResponseStateNotifier(repository: repo, throttleManager: throttleManager);
});