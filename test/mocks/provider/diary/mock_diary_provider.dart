import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';

import '../../repository/diary/mock_diary_repository.dart';
import 'api_response/mock_dary_api_response_provider.dart';

final mockDiaryProvider =
StateNotifierProvider<DiaryStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockDiaryRepositoryProvider);

  final notifier = DiaryStateNotifier(repository: repo);

  return notifier;
});


