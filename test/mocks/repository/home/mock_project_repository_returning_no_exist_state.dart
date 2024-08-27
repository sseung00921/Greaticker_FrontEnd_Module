import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/model/request_dto/project_request_dto.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final MockProjectRepositoryReturningNoExistProvider = Provider<MockProjectRepositoryReturningNoExist>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockProjectRepositoryReturningNoExist(dio, baseUrl: 'http://$ip/home');
  },
);

class MockProjectRepositoryReturningNoExist extends ProjectRepositoryBase {
  MockProjectRepositoryReturningNoExist(Dio dio, {required String baseUrl});

  ProjectModel mockCompletedStateData = ProjectModel(
      projectStateKind: ProjectStateKind.NO_EXIST,
      startDate: DateTime.now(),
      dayInARow: 0
  );
  ApiResponse<String> mockGotStickerData =
  ApiResponse<String>(
    isSuccess: true,
    data: "1",
  );
  ApiResponse<String> mockAipResponseData = ApiResponse<String>(isSuccess: true,);

  @override
  Future<ApiResponse<ProjectModel>> getProjectModel() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return ApiResponse(isSuccess: true, data: mockCompletedStateData);
  }

  @override
  Future<ApiResponse<String>> getNewSticker() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockGotStickerData;
  }

  @override
  Future<ApiResponse<String>> updateProjectState(
      {required ProjectRequestDto projectRequestDto}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockAipResponseData;
  }
}
