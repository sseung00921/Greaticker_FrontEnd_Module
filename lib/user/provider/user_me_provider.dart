import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/platform.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/secure_storage/secure_storage.dart';
import 'package:greaticker/user/model/login_response.dart';
import 'package:greaticker/user/model/user_model.dart';
import 'package:greaticker/user/repository/user_me_repository.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, ApiResponseBase>(
  (ref) {
    final authRepository = ref.watch(UserMeRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);

    return UserMeStateNotifier(
      authRepository: authRepository,
      storage: storage,
    );
  },
);

class UserMeStateNotifier extends StateNotifier<ApiResponseBase> {
  final UserMeRepository authRepository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.storage,
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

  Future<ApiResponseBase?> loginWithGoogle() async {
    try {
      state = ApiResponseLoading();
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      String platForm = Platform.isAndroid ? ANDROID : iOS;

      final resp = await authRepository.loginWithGoogle(
        authHeader: "Bearer " + googleAuth.idToken!,
        platform: platForm,
      );
      resp as ApiResponse;
      state = resp;
      LoginResponse loginResponse = resp.data as LoginResponse;

      await storage.write(key: JWT_TOKEN, value: loginResponse.jwtToken);
      return state;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(
          message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
      return state;
    }
  }

  Future<void> logOut() async {
    await storage.delete(key: JWT_TOKEN);
    state = ApiResponseError(message: "loaded User no exist since logged Out");
  }

  Future<ApiResponseBase> deleteAccount() async {
    try {
      await authRepository.deleteAccount();
      await storage.delete(key: JWT_TOKEN);
      state = ApiResponseError(message: "loaded User no exist since user is deleted");
      return state;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(
          message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
      return state;
    }
  }
}
