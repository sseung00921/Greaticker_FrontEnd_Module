import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/home/repository/mock_project_repository.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final projectProvider =
StateNotifierProvider<ProjectStateNotifier, ProjectModelBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryProvider);
  final notifier = ProjectStateNotifier(repository: repo);

  ref.watch(gotStickerProvider);
  ref.watch(projectApiResponseProvider);

  ref.listen<GotStickerModelBase>(gotStickerProvider, (previous, next) {
    if (next is GotStickerModelLoading) {
      notifier.setLoadingState();
    } else if (next is GotStickerModelError) {
      notifier.setErrorState();
    } else {
      notifier.getProjectModel();
    };
  });

  ref.listen<ApiResponseBase>(projectApiResponseProvider, (previous, next) {
    if (next is ApiResponseLoading) {
      notifier.setLoadingState();
    } else if (next is ApiResponseError) {
      notifier.setErrorState();
    } else {
      notifier.getProjectModel();
    };
  });

  return notifier;
});

class ProjectStateNotifier extends StateNotifier<ProjectModelBase> {
  final ProjectRepositoryBase repository;

  ProjectStateNotifier({required this.repository}) : super(ProjectModelLoading()) {
    getProjectModel();
  }

  Future<void> getProjectModel() async {
    try {
      final resp = await repository.getProjectModel();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ProjectModelError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  void updateProjectState(ProjectModel updatedState) {
    state = updatedState;
  }

  void setLoadingState() {
    state = ProjectModelLoading();
  }

  void setErrorState() {
    state = ProjectModelError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
  }
}
