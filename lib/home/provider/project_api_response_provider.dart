import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/request_dto/project_request_dto.dart';
import 'package:greaticker/home/repository/mock_project_repository.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final projectApiResponseProvider =
StateNotifierProvider<ProjectApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryProvider);

  return ProjectApiResponseStateNotifier(repository: repo);
});

class ProjectApiResponseStateNotifier extends StateNotifier<ApiResponseBase> {

  final ProjectRepositoryBase repository;

  ProjectApiResponseStateNotifier({required this.repository}) : super(ApiResponseLoading());


  Future<void> updateProjectState({required ProjectRequestDto projectRequestDto}) async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.updateProjectState(projectRequestDto: projectRequestDto);
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }
}