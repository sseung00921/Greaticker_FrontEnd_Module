import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';

import '../../repository/diary/mock_diary_repository.dart';

final mockDiaryProvider =
StateNotifierProvider<DiaryStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockDiaryRepositoryProvider);

  return DiaryStateNotifier(repository: repo);
});


