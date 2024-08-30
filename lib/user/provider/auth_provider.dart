import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/user/model/user_model.dart';
import 'package:greaticker/user/provider/user_me_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<ApiResponseBase>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  void logout(){
    ref.read(userMeProvider.notifier).logout();
  }

  // SplashScreen
  // 앱을 처음 시작했을때
  // 토큰이 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지
  // 홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(BuildContext context, GoRouterState state) {
    final ApiResponseBase user = ref.read(userMeProvider);

    final loginIn = state.location == '/login';

    if (user is ApiResponseLoading) {
      return loginIn ? null : '/login';
    } else if (user is ApiResponseError) {
      return !loginIn ? '/login' : null;
    } else {
      //정상적으로 로그인된 유저 정보를 가져온 경우
      return loginIn || state.location == '/splash' ? '/home/project' : null;
    }
  }
}
