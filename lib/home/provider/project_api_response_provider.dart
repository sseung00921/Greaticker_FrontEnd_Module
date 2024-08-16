import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/requestDto/project_request_dto.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final projectApiResponseProvider =
StateNotifierProvider<ProjectApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(ProjectRepositoryProvider);

  return ProjectApiResponseStateNotifier(repository: repo);
});

class ProjectApiResponseStateNotifier extends StateNotifier<ApiResponseBase> {

  final ProjectRepositoryBase repository;

  ProjectApiResponseStateNotifier({required this.repository}) : super(ApiResponseLoading());


  Future<void> getProjectModel({required ProjectRequestDto projectRequestDto}) async {
    try {
      final resp = await repository.updateProjectState(projectRequestDto: projectRequestDto);
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}