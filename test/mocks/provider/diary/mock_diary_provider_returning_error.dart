import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';

import '../../repository/diary/mock_diary_repository.dart';
import '../../repository/diary/mock_diary_repository_returning_error.dart';

final mockDiaryProviderReturningError =
StateNotifierProvider<DiaryStateNotifier, DiaryModelBase>((ref) {
  final repo = ref.watch(MockDiaryRepositoryReturningErrorProvider);

  return DiaryStateNotifier(repository: repo);
});


