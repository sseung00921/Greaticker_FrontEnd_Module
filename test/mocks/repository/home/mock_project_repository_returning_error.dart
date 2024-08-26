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
import 'package:greaticker/home/model/request_dto/project_request_dto.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final MockProjectRepositoryReturningErrorProvider = Provider<MockProjectRepositoryReturningError>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockProjectRepositoryReturningError(dio, baseUrl: 'http://$ip/home');
  },
);

class MockProjectRepositoryReturningError extends ProjectRepositoryBase {
  MockProjectRepositoryReturningError(Dio dio, {required String baseUrl});

  ProjectModel mockErrorData = ProjectModel(
    projectStateKind: ProjectStateKind.NO_EXIST,
  );
  ApiResponse<GotStickerModel> mockGotStickerData =
  ApiResponse<GotStickerModel>(
    isSuccess: true,
    data: GotStickerModel(id: "1", isAlreadyGotTodaySticker: false),
  );
  ApiResponse<String> mockAipResponseData = ApiResponse<String>(isSuccess: true,);

  @override
  Future<ApiResponse<ProjectModel>> getProjectModel() async {
    throw Exception();
  }

  @override
  Future<ApiResponse<GotStickerModel>> getNewSticker() async {
    throw Exception();
  }

  @override
  Future<ApiResponse<String>> updateProjectState(
      {required ProjectRequestDto projectRequestDto}) async {
    throw Exception();
  }
}
