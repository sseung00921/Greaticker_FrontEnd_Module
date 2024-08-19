import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/repository/project_repository.dart';

import '../../../repository/home/mock_project_repository_returning_in_progress_state.dart';

final mockGotStickerProvider =
StateNotifierProvider<GotStickerStateNotifier, GotStickerModelBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryReturningInProgressProvider);

  return GotStickerStateNotifier(repository: repo);
});


