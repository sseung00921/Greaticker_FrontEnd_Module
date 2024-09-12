import 'package:go_router/go_router.dart';
import 'package:greaticker/common/model/api_response.dart';

class AuthUtils {
  static String? redirectLogic(GoRouterState state, ApiResponseBase user) {
    final loginIn = state.location == '/login';
    if (user is ApiResponseLoading) {
      return null;
    } else if (user is ApiResponseError) {
      return '/login';
    } else {
      return loginIn || state.location == '/splash' ? '/login' : null;
    }
  }
}