import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/provider/profile_provider.dart';

import '../../repository/diary/mock_diary_repository.dart';
import '../../repository/profile/mock_profile_repositry.dart';

final mockProfileProvider =
StateNotifierProvider<ProfileStateNotifier, ProfileModelBase>((ref) {
  final repo = ref.watch(MockProfileRepositoryProvider);

  return ProfileStateNotifier(repository: repo);
});


