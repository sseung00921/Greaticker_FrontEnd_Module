import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/repository/diary_repository.dart';
import 'package:greaticker/diary/repository/mock_diary_repository.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';

final diaryProvider =
StateNotifierProvider<DiaryStateNotifier, DiaryModelBase>((ref) {
  final repo = ref.watch(MockDiaryRepositoryProvider);
  final notifier = DiaryStateNotifier(repository: repo);

  ref.listen<ApiResponseBase>(hallOfFameApiResponseProvider, (previous, next) {
    if (next is ApiResponseLoading) {
      notifier.setLoadingState();
    } else if (next is ApiResponseError) {
      notifier.setErrorState();
    } else {
      notifier.getDiaryModel();
    };
  });

  return notifier;
});

class DiaryStateNotifier extends StateNotifier<DiaryModelBase> {

  final DiaryRepositoryBase repository;

  DiaryStateNotifier({required this.repository}) : super(DiaryModelLoading()) {
    getDiaryModel();
  }

  Future<void> getDiaryModel() async {
    try {
      final resp = await repository.getDiaryModel();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = DiaryModelError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  void setLoadingState() {
    state = DiaryModelLoading();
  }

  void setErrorState() {
    state = DiaryModelError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
  }
}
