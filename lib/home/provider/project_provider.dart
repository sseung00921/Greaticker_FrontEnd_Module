import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/home/repository/mock_project_repository.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final projectProvider =
StateNotifierProvider<ProjectStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryProvider);
  final notifier = ProjectStateNotifier(repository: repo);

  ref.listen<ApiResponseBase>(gotStickerProvider, (previous, next) {
    if (next is GotStickerModelLoading) {
      notifier.setLoadingState();
    } else if (next is GotStickerModelError) {
      notifier.setErrorState();
    } else {
      //이 코드는 백엔드 개발까지 구현된 직후 다시 주석을 해제해야함 ToBeOpened
      notifier.getProjectModel();
    };
  });

  ref.listen<ApiResponseBase>(projectApiResponseProvider, (previous, next) {
    if (next is ApiResponseLoading) {
      notifier.setLoadingState();
    } else if (next is ApiResponseError) {
      notifier.setErrorState();
    } else {
      //이 코드는 백엔드 개발까지 구현된 직후 다시 주석을 해제해야함 ToBeOpened
      //notifier.getProjectModel();
    };
  });

  ref.listen<ApiResponseBase>(hallOfFameApiResponseProvider, (previous, next) {
    if (next is ApiResponseLoading) {
      notifier.setLoadingState();
    } else if (next is ApiResponseError) {
      notifier.setErrorState();
    } else {
      //notifier.getProjectModel();
    };
  });

  return notifier;
});

class ProjectStateNotifier extends StateNotifier<ApiResponseBase> {
  final ProjectRepositoryBase repository;

  ProjectStateNotifier({required this.repository}) : super(ApiResponseLoading()) {
    getProjectModel();
  }

  Future<void> getProjectModel() async {
    try {
      final resp = await repository.getProjectModel();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  void updateProjectState(ProjectModel updatedState) {
    state = ApiResponse(isSuccess: true, data: updatedState);
  }

  void setLoadingState() {
    state = ApiResponseLoading();
  }

  void setErrorState() {
    state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
  }
}
