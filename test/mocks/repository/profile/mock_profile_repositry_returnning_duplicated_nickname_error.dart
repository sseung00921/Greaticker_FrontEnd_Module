import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/error_message/error_message.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/profile/model/change_nickname_result_model.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:greaticker/profile/repository/profile_repository.dart';

final MockProfileRepositoryProviderReturningDuplicatedNicknameError = Provider<MockProfileRepositoryReturningDuplicatedNicknameError>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return MockProfileRepositoryReturningDuplicatedNicknameError(dio, baseUrl: 'http://$ip/profile');
  },
);

class MockProfileRepositoryReturningDuplicatedNicknameError extends ProfileRepositoryBase {
  MockProfileRepositoryReturningDuplicatedNicknameError(Dio dio, {required String baseUrl});

  ProfileModel mockProfileData = ProfileModel(userNickname: "뾰롱뾰롱이");
  ApiResponse<String> mockAipResponseData =
      ApiResponse<String>(isSuccess: true,);

  ApiResponse<ChangeNicknameResultModel> mockChangeNicknameAipResponseData =
      ApiResponse<ChangeNicknameResultModel>(isSuccess: false, message: DUPLICATED_NICKNAME);



  @override
  Future<ApiResponse<ProfileModel>> getProfileModel() async {
    // TODO: implement getProfileModel
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return ApiResponse(isSuccess: true, data: mockProfileData);
  }

  @override
  Future<ApiResponse<ChangeNicknameResultModel>> changeNickname(
      {required ChangeNicknameRequestDto changeNicknameRequestDto}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockChangeNicknameAipResponseData;
  }
  
  @override
  Future<ApiResponse<String>> logOut() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockAipResponseData;
  }

  @override
  Future<ApiResponse<String>> deleteAccount() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockAipResponseData;
  }
}
