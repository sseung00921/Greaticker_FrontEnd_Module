import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/model/request_dto/project_request_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'project_repository.g.dart';

final ProjectRepositoryProvider = Provider<ProjectRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return ProjectRepository(dio, baseUrl: 'https://$ip/home');
  },
);

// http://$ip/product
@RestApi()
abstract class ProjectRepository extends ProjectRepositoryBase{
  factory ProjectRepository(Dio dio, {String baseUrl}) = _ProjectRepository;

  @GET('/project')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<ProjectModel>> getProjectModel();

  @POST('/project')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<String>> updateProjectState({
    @Body() required ProjectRequestDto projectRequestDto,
  });

  @POST('/get-sticker')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<String>> getNewSticker();
}

abstract class ProjectRepositoryBase {

  Future<ApiResponse<ProjectModel>> getProjectModel();
  Future<ApiResponse<String>> updateProjectState({
    required ProjectRequestDto projectRequestDto,
  });
  Future<ApiResponse<String>> getNewSticker();

}