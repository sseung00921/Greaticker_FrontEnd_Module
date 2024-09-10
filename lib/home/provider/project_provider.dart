import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/pagenation.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';
import 'package:greaticker/history/provider/history_provider.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/home/repository/mock_project_repository.dart';
import 'package:greaticker/home/repository/project_repository.dart';
import 'package:greaticker/popular_chart/provider/popular_chart_provider.dart';

final projectProvider =
StateNotifierProvider<ProjectStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(ProjectRepositoryProvider);
  final notifier = ProjectStateNotifier(repository: repo);
  final historyNotifier = ref.read(historyProvider.notifier);
  final diaryNotifier = ref.read(diaryProvider.notifier);
  final popularChartNotifier = ref.read(popularChartProvider.notifier);

  ref.listen<ApiResponseBase>(gotStickerProvider, (previous, next) {
    if (next is ApiResponseLoading) {
      notifier.setLoadingState();
    } else if (next is ApiResponseError) {
      notifier.setErrorState();
    } else {
      notifier.getProjectModel();
      historyNotifier.paginate(forceRefetch: true);
      diaryNotifier.getDiaryModel();
      popularChartNotifier.paginate(forceRefetch: true);
    };
  });

  ref.listen<ApiResponseBase>(projectApiResponseProvider, (previous, next) {
    if (next is ApiResponseLoading) {
      notifier.setLoadingState();
    } else if (next is ApiResponseError) {
      notifier.setErrorState();
    } else {
      notifier.getProjectModel();
      historyNotifier.paginate(forceRefetch: true);
      diaryNotifier.getDiaryModel();
      popularChartNotifier.paginate(forceRefetch: true);
    };
  });

  ref.listen<ApiResponseBase>(hallOfFameApiResponseProvider, (previous, next) {
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

class ProjectStateNotifier extends StateNotifier<ApiResponseBase> {
  final ProjectRepositoryBase repository;

  ProjectStateNotifier({required this.repository}) : super(ApiResponseLoading()) {
    getProjectModel();
  }

  Future<void> getProjectModel() async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.getProjectModel();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  Future<void> updateProjectState(ProjectModel updatedState) async {
    state = ApiResponse(isSuccess: true, data: updatedState);
  }

  void setLoadingState() {
    state = ApiResponseLoading();
  }

  void setErrorState() {
    state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
  }
}
