import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/project_provider.dart';

import '../../../repository/home/mock_project_repository_returning_no_exist_state.dart';

final mockProjectProviderReturningNoExist =
StateNotifierProvider<ProjectStateNotifier, ProjectModelBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryReturningNoExistProvider);

  return ProjectStateNotifier(repository: repo);
});


