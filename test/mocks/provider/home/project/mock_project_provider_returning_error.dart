import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/project_provider.dart';

import '../../../repository/home/mock_project_repository_returning_error.dart';

final mockProjectProviderReturningError =
StateNotifierProvider<ProjectStateNotifier, ProjectModelBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryReturningErrorProvider);

  return ProjectStateNotifier(repository: repo);
});


