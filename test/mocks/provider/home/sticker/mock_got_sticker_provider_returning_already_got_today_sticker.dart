import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';

import '../../../repository/home/mock_project_repository_returning_already_got_today_sticker.dart';

final mockGotStickerProviderReturningAlreadyGotTodaySticker =
StateNotifierProvider<GotStickerStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryReturningAlreadyGotTodayStickerProvider);
  final throttleManager = ref.watch(throttleManagerProvider);

  return GotStickerStateNotifier(repository: repo, throttleManager: throttleManager);
});

