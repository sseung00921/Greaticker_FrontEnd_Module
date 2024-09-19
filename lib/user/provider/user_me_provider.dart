import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/error_message/error_message.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/platform.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/secure_storage/secure_storage.dart';
import 'package:greaticker/common/throttle_manager/throttle_manager.dart';
import 'package:greaticker/user/model/login_response.dart';
import 'package:greaticker/user/model/user_model.dart';
import 'package:greaticker/user/repository/user_me_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, ApiResponseBase>(
  (ref) {
    final authRepository = ref.watch(UserMeRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);
    final throttleManager = ref.read(throttleManagerProvider);

    return UserMeStateNotifier(
      authRepository: authRepository,
      storage: storage,
      throttleManager: throttleManager,
    );
  },
);

class UserMeStateNotifier extends StateNotifier<ApiResponseBase> {
  final UserMeRepositoryBase authRepository;
  final FlutterSecureStorage storage;
  final ThrottleManager throttleManager;

  UserMeStateNotifier({
    required this.authRepository,
    required this.storage,
    required this.throttleManager,
  }) : super(ApiResponseLoading()) {
    // 내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final jwtToken = await storage.read(key: JWT_TOKEN);
    if (jwtToken == null) {
      state = ApiResponseError(message: "No JWT Token.");
    } else {
      try {
        if (state is ApiResponseError) {
          state = ApiResponseLoading();
        }
        final userResp = await authRepository.getMe();
        state = userResp;
      } catch (e, stack) {
        print(e);
        print(stack);
        state = ApiResponseError(
            message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
      }
    }
  }

  Future<ApiResponseBase?> loginWithGoogle({required BuildContext context}) async {
    return await throttleManager
        .executeWithModal("loginWithGoogle", context, () async {
      try {
        state = ApiResponseLoading();
        String idToken;
        var res = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
        // Fetch the current user session
        var session = await Amplify.Auth.fetchAuthSession();

        // Ensure the session is valid and authenticated
        if (session.isSignedIn) {
          // Get Cognito credentials
          var cognitoSession = session as CognitoAuthSession;

          // Fetch the ID token from the session
          idToken = cognitoSession.userPoolTokensResult.value.idToken.raw;

          String platForm = Platform.isAndroid ? ANDROID : iOS;

          final resp = await authRepository.login(
            authHeader: "Bearer " + idToken,
            platform: platForm,
          );
          resp as ApiResponse;
          state = resp;
          LoginResponse loginResponse = resp.data as LoginResponse;

          await storage.write(key: JWT_TOKEN, value: loginResponse.jwtToken);

          if (idToken == null) {
            print("Failed to get ID Token.");
          }
        } else {
          print("User is not signed in.");
        };

        return state;
      } catch (e, stack) {
        print(e);
        print(stack);
        state = ApiResponseError(
            message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
        return state;
      }
    });
  }

  Future<ApiResponseBase?> loginWithApple({required BuildContext context}) async {
    return await throttleManager
        .executeWithModal("loginWithApple", context, () async {
      try {
        print("aaaaaa");
        state = ApiResponseLoading();
        String idToken;
        var res = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.apple);
        // Fetch the current user session
        var session = await Amplify.Auth.fetchAuthSession();

        // Ensure the session is valid and authenticated
        if (session.isSignedIn) {
          // Get Cognito credentials
          var cognitoSession = session as CognitoAuthSession;

          // Fetch the ID token from the session
          idToken = cognitoSession.userPoolTokensResult.value.idToken.raw;

          String platForm = Platform.isAndroid ? ANDROID : iOS;

          final resp = await authRepository.login(
            authHeader: "Bearer " + idToken,
            platform: platForm,
          );
          resp as ApiResponse;
          state = resp;
          LoginResponse loginResponse = resp.data as LoginResponse;

          await storage.write(key: JWT_TOKEN, value: loginResponse.jwtToken);

          if (idToken == null) {
            print("Failed to get ID Token.");
          }
        } else {
          print("User is not signed in.");
        };

        return state;
      } catch (e, stack) {
        print(e);
        print(stack);
        state = ApiResponseError(
            message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
        return state;
      }
    });
  }

  Future<ApiResponseBase?> logOut() async {
    try {
      await Amplify.Auth.signOut();
      await storage.delete(key: JWT_TOKEN);
      state = ApiResponseError(message: GET_ME_FAILED_SINCE_USER_LOG_OUT);
      return state;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(
          message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
      return state;
    }
  }

  Future<ApiResponseBase?> deleteAccount({required BuildContext context}) async {
    return await throttleManager
        .executeWithModal("deleteAccount", context, () async {
      try {
        await authRepository.deleteAccount();
        await Amplify.Auth.deleteUser();
        await storage.delete(key: JWT_TOKEN);
        state = ApiResponseError(
            message: GET_ME_FAILED_SINCE_USER_DELETE_ACCOUNT);
        return state;
      } catch (e, stack) {
        print(e);
        print(stack);
        state = ApiResponseError(
            message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
        return state;
      }
    });
  }

  void setErrorState() {
    state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
  }
}
