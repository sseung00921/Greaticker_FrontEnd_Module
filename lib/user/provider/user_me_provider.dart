import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/secure_storage/secure_storage.dart';
import 'package:greaticker/user/model/login_response.dart';
import 'package:greaticker/user/model/request_dto/google_token_request_dto.dart';
import 'package:greaticker/user/model/user_model.dart';
import 'package:greaticker/user/repository/user_me_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier, ApiResponseBase>(
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
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      return;
    }
    try {
      final userResp = await authRepository.getMe();
      state = userResp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }

  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      GoogleTokenRequestDto googleTokenRequestDto = new GoogleTokenRequestDto(token: googleAuth.idToken!);

      final userResp = await authRepository.loginWithGoogle(googleTokenRequestDto);
      userResp as ApiResponse;
      state = userResp;
      LoginResponse loginResponse = userResp.data as LoginResponse;

      await storage.write(key: REFRESH_TOKEN_KEY, value: loginResponse.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: loginResponse.accessToken);
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  Future<void> logout() async {
    await Future.wait(
      [
        storage.delete(key: REFRESH_TOKEN_KEY),
        storage.delete(key: ACCESS_TOKEN_KEY),
      ],
    );
  }
}
