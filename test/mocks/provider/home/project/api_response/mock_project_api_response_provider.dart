import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/provider/profile_api_response_provider.dart';
import 'package:greaticker/profile/provider/profile_provider.dart';

import '../../../../repository/home/mock_project_repository_returning_in_progress_state.dart';


final mockProjectApiResponseProvider =
StateNotifierProvider<ProjectApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryReturningInProgressProvider);
  final throttleManager = ref.watch(throttleManagerProvider);

  return ProjectApiResponseStateNotifier(repository: repo, throttleManager: throttleManager);
});


