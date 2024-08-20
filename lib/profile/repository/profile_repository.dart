import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_repository.g.dart';

final ProfieRepositoryProvider = Provider<ProfileRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return ProfileRepository(dio, baseUrl: 'http://$ip/profile');
  },
);

// http://$ip/product
@RestApi()
abstract class ProfileRepository extends ProfileRepositoryBase{
  factory ProfileRepository(Dio dio, {String baseUrl}) = _ProfileRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  @override
  Future<ProfileModel> getProfileModel();

  @POST('/changeNickname')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<String>> changeNickname({
    @Body() required ChangeNicknameRequestDto changeNicknameRequestDto,
  });

  @POST('/logOut')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<String>> logOut();

  @POST('/deleteAccount')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<String>> deleteAccount();
}

abstract class ProfileRepositoryBase {

  Future<ProfileModel> getProfileModel();
  Future<ApiResponse<String>> changeNickname({
    required ChangeNicknameRequestDto changeNicknameRequestDto,
  });
  Future<ApiResponse<String>> logOut();
  Future<ApiResponse<String>> deleteAccount();

}