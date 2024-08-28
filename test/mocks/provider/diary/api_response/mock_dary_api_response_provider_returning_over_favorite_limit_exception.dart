
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/diary/provider/diary_api_response_provider.dart';

import '../../../repository/diary/mock_diary_repository.dart';
import '../../../repository/diary/mock_diary_repository_returning_over_favorite_limit_exception.dart';

final mockDiaryApiResponseProviderReturningOverFavoriteLimitException =
StateNotifierProvider<DiaryApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockDiaryRepositoryReturingOverFavoriteLimitExceptionProvider);
  final throttleManager = ref.watch(throttleManagerProvider);

  return DiaryApiResponseStateNotifier(repository: repo, throttleManager: throttleManager);
});