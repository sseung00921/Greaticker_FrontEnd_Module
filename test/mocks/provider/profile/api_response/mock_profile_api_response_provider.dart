import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/provider/profile_api_response_provider.dart';
import 'package:greaticker/profile/provider/profile_provider.dart';

import '../../../repository/diary/mock_diary_repository.dart';
import '../../../repository/profile/mock_profile_repositry.dart';
import '../../../repository/profile/mock_profile_repositry_returnning_duplicated_nickname_error.dart';

final mockProfileApiResponseProvider =
StateNotifierProvider<ProfileApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProfileRepositoryProvider);
  final throttleManager = ref.watch(throttleManagerProvider);

  return ProfileApiResponseStateNotifier(repository: repo, throttleManager: throttleManager);
});


