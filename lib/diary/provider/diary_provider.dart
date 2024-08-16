import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/repository/diary_repository.dart';
import 'package:greaticker/diary/repository/mock_diary_repository.dart';

final diaryProvider =
StateNotifierProvider<DiaryStateNotifier, DiaryModelBase>((ref) {
  final repo = ref.watch(MockDiaryRepositoryProvider);

  return DiaryStateNotifier(repository: repo);
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
      state = DiaryModelError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
