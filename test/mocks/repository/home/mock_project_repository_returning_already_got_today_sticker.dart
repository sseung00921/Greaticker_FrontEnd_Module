import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/error_message/error_message.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/model/request_dto/project_request_dto.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final MockProjectRepositoryReturningAlreadyGotTodayStickerProvider =
    Provider<MockProjectRepositoryReturningAlreadyGotTodaySticker>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return MockProjectRepositoryReturningAlreadyGotTodaySticker(dio,
        baseUrl: 'http://$ip/home');
  },
);

class MockProjectRepositoryReturningAlreadyGotTodaySticker
    extends ProjectRepositoryBase {
  MockProjectRepositoryReturningAlreadyGotTodaySticker(Dio dio,
      {required String baseUrl});

  ProjectModel mockInProgressStateData = ProjectModel(
      projectName: "앱 만들기",
      projectStateKind: ProjectStateKind.IN_PROGRESS,
      startDate: DateTime.now().subtract(Duration(days: 29)),
      dayInARow: 28);
  ApiResponse<String> mockGotStickerData =
      ApiResponse<String>(
    isSuccess: false,
    message: TODAY_STICKER_ALREADY_GOT,
  );
  ApiResponse<String> mockAipResponseData =
      ApiResponse<String>(isSuccess: true,);

  @override
  Future<ApiResponse<ProjectModel>> getProjectModel() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return ApiResponse(isSuccess: true, data: mockInProgressStateData);
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
