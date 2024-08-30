import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/profile/model/change_nickname_result_model.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:greaticker/user/model/login_response.dart';
import 'package:greaticker/user/model/request_dto/google_token_request_dto.dart';
import 'package:greaticker/user/model/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_me_repository.g.dart';

final UserMeRepositoryProvider = Provider<UserMeRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return UserMeRepository(dio, baseUrl: 'http://$ip/auth');
  },
);

// http://$ip/product
@RestApi()
abstract class UserMeRepository extends ProfileRepositoryBase{
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/get-me')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<UserModel>> getMe();

  @GET('/google')
  @Headers({'Content-Type': 'application/json'})
  @override
  Future<ApiResponse<LoginResponse>> loginWithGoogle(@Body() GoogleTokenRequestDto tokenRequest);
}

abstract class ProfileRepositoryBase {

  Future<ApiResponse<LoginResponse>> loginWithGoogle(@Body() GoogleTokenRequestDto tokenRequest);
  Future<ApiResponse<UserModel>> getMe();
}