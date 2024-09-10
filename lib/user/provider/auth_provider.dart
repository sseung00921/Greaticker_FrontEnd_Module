import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_provider.dart';
import 'package:greaticker/history/provider/history_provider.dart';
import 'package:greaticker/home/provider/project_provider.dart';
import 'package:greaticker/popular_chart/provider/popular_chart_provider.dart';
import 'package:greaticker/profile/provider/profile_provider.dart';
import 'package:greaticker/user/model/user_model.dart';
import 'package:greaticker/user/provider/user_me_provider.dart';
import 'package:greaticker/user/utils/auth_utils.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<ApiResponseBase>(userMeProvider, (previous, next) {
      if (previous is ApiResponseLoading && next is ApiResponse) {
        clearAllProviderStates();
      }
    });
  }

  void clearAllProviderStates() {
    ref.read(profileProvider.notifier).getProfileModel();
    ref.read(popularChartProvider.notifier).paginate(forceRefetch: true);
    ref.read(projectProvider.notifier).getProjectModel();
    ref.read(historyProvider.notifier).paginate(forceRefetch: true);
    ref.read(hallOfFameProvider.notifier).paginate(forceRefetch: true);
    ref.read(diaryProvider.notifier).getDiaryModel();
  }

  // SplashScreen
  // 앱을 처음 시작했을때
  // 토큰이 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지
  // 홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirect(BuildContext context, GoRouterState state) {
    final ApiResponseBase user = ref.read(userMeProvider);
    return AuthUtils.redirectLogic(state, user);
  }


}
