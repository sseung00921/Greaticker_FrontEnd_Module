import 'package:go_router/go_router.dart';
import 'package:greaticker/common/model/api_response.dart';

class AuthUtils {
  static String? redirectLogic(GoRouterState state, ApiResponseBase user) {
    final loginIn = state.location == '/login';
    if (user is ApiResponseLoading) {
      return null;
    } else if (user is ApiResponseError) {
      return loginIn ? null : '/login';
    } else {
      //정상적으로 로그인된 유저 정보를 가져온 경우
      return loginIn || state.location == '/splash' ? '/home' : null;
    }
  }
}