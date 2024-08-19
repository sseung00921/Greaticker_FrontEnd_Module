import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/model/requestDto/project_request_dto.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final MockProjectRepositoryReturningResetProvider = Provider<MockProjectRepositoryReturningReset>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockProjectRepositoryReturningReset(dio, baseUrl: 'http://$ip/home');
  },
);

class MockProjectRepositoryReturningReset extends ProjectRepositoryBase {
  MockProjectRepositoryReturningReset(Dio dio, {required String baseUrl});

  ProjectModel mockResetStateData = ProjectModel(
    projectStateKind: ProjectStateKind.RESET,
  );
  GotStickerModel mockGotStickerData = GotStickerModel(id: "1", isAlreadyGotTodaySticker: false);
  ApiResponse<int> mockAipResponseData = ApiResponse<int>(isSuccess: true, isError: false);

  @override
  Future<ProjectModel> getProjectModel() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockResetStateData;
  }

  @override
  Future<GotStickerModel> getNewSticker() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockGotStickerData;
  }

  @override
  Future<ApiResponse<int>> updateProjectState(
      {required ProjectRequestDto projectRequestDto}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockAipResponseData;
  }
}
