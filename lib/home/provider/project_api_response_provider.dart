import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/request_dto/project_request_dto.dart';
import 'package:greaticker/home/repository/mock_project_repository.dart';
import 'package:greaticker/home/repository/project_repository.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';

final projectApiResponseProvider =
StateNotifierProvider<ProjectApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(ProjectRepositoryProvider);
  final throttleManager = ref.read(throttleManagerProvider); // ThrottleManager 추가

  return ProjectApiResponseStateNotifier(repository: repo, throttleManager: throttleManager);
});

class ProjectApiResponseStateNotifier extends StateNotifier<ApiResponseBase> {
  final ProjectRepositoryBase repository;
  final ThrottleManager throttleManager; // ThrottleManager 필드 추가

  ProjectApiResponseStateNotifier({
    required this.repository,
    required this.throttleManager,
  }) : super(ApiResponseLoading());

  Future<ApiResponseBase?> updateProjectState({
    required ProjectRequestDto projectRequestDto,
    required BuildContext context,
    bool showThrottleModal = true,// Context 추가
  }) async {
    if (showThrottleModal) {
      return await throttleManager.executeWithModal(
          "updateProjectState", context, () async {
        return await _updateProjectState(projectRequestDto);
      });
    } else {
      return await throttleManager.execute(
          "updateProjectState", () async {
        return await _updateProjectState(projectRequestDto);
      });
    }
  }

  Future<ApiResponseBase> _updateProjectState(ProjectRequestDto projectRequestDto) async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.updateProjectState(
          projectRequestDto: projectRequestDto);
      state = resp;
      print(resp.isSuccess);
      print(resp.message);
      return state;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(
          message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
      return state;
    }
  }
}
