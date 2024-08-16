import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final projectProvider =
StateNotifierProvider<ProjectStateNotifier, ProjectModelBase>((ref) {
  ref.watch(gotStickerProvider);
  ref.watch(projectApiResponseProvider);

  final repo = ref.watch(ProjectRepositoryProvider);

  return ProjectStateNotifier(repository: repo);
});

class ProjectStateNotifier extends StateNotifier<ProjectModelBase> {
  final ProjectRepositoryBase repository;

  ProjectStateNotifier({required this.repository}) : super(ProjectModelLoading()) {
    getProjectModel();
  }

  Future<void> getProjectModel() async {
    try {
      final resp = await repository.getProjectModel();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ProjectModelError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
