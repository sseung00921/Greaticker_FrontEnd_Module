import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/project_provider.dart';

import '../../../repository/home/mock_project_repository_returning_reset_state.dart';

final mockProjectProviderReturningReset =
StateNotifierProvider<ProjectStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryReturningResetProvider);

  return ProjectStateNotifier(repository: repo);
});


