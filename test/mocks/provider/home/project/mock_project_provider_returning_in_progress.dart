import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/project_provider.dart';

import '../../../repository/home/mock_project_repository_returning_in_progress_state.dart';
import '../sticker/mock_got_sticker_provider.dart';

final mockProjectProviderReturningInProgress =
StateNotifierProvider<ProjectStateNotifier, ProjectModelBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryReturningInProgressProvider);
  final notifier = ProjectStateNotifier(repository: repo);

  ref.listen<ApiResponseBase>(mockGotStickerProvider, (previous, next) {
    if (next is GotStickerModelLoading) {
      notifier.setLoadingState();
    } else if (next is GotStickerModelError) {
      notifier.setErrorState();
    } else {
      //이 코드는 백엔드 개발까지 구현된 직후 다시 주석을 해제해야함 ToBeOpened
      notifier.getProjectModel();
    };
  });

  return notifier;
});


