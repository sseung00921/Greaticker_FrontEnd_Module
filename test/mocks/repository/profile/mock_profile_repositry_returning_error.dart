import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/error_message/error_message.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:greaticker/profile/repository/profile_repository.dart';

final MockProfileRepositoryReturningErrorProvider = Provider<MockProfileRepositoryReturningError>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return MockProfileRepositoryReturningError(dio, baseUrl: 'http://$ip/profile');
  },
);

class MockProfileRepositoryReturningError extends ProfileRepositoryBase {
  MockProfileRepositoryReturningError(Dio dio, {required String baseUrl});

  ApiResponse<String> mockAipResponseData =
      ApiResponse<String>(isSuccess: true, isError: false);

  ApiResponse<String> mockChangeNicknameAipResponseData =
      ApiResponse<String>(isSuccess: true, isError: false, data: "뉴뾰롱뾰롱이");

  
  
  @override
  Future<ProfileModel> getProfileModel() async {
    // TODO: implement getProfileModel
    throw Exception();
  }

  @override
  Future<ApiResponse<String>> changeNickname(
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
