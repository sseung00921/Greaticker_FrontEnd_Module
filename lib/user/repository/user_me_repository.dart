import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/user/model/login_response.dart';
import 'package:greaticker/user/model/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_me_repository.g.dart';

final UserMeRepositoryProvider = Provider<UserMeRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return UserMeRepository(dio, baseUrl: 'https://$ip/auth');
  },
);

// http://$ip/product
@RestApi()
abstract class UserMeRepository extends UserMeRepositoryBase {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/get-me')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<UserModel>> getMe();

  @POST('/login')
  @Headers({'Content-Type': 'application/json'})
  @override
  Future<ApiResponse<LoginResponse>> login({
      @Header("Authorization") required String authHeader,
      @Header("X-Platform") required String platform});

  @POST('/delete-account')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<UserModel>> deleteAccount();
}

abstract class UserMeRepositoryBase {
  Future<ApiResponse<LoginResponse>> login({
      @Header("Authorization") required String authHeader,
      @Header("X-Platform") required String platform});

  Future<ApiResponse<UserModel>> getMe();
  Future<ApiResponse<UserModel>> deleteAccount();
}
