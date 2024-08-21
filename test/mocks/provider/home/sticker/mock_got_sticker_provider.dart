import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/repository/project_repository.dart';

import '../../../repository/home/mock_project_repository_returning_in_progress_state.dart';

final mockGotStickerProvider =
StateNotifierProvider<GotStickerStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryReturningInProgressProvider);
  final throttleManager = ref.watch(throttleManagerProvider);

  return GotStickerStateNotifier(repository: repo, throttleManager: throttleManager);
});


