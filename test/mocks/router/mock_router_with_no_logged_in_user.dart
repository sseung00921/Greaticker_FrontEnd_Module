import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greaticker/common/constants/params.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/view/login_screen.dart';
import 'package:greaticker/common/view/splash_screen.dart';
import 'package:greaticker/diary/provider/diary_api_response_provider.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:greaticker/diary/view/diary_screen.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_provider.dart';
import 'package:greaticker/hall_of_fame/view/hall_of_fame_screen.dart';
import 'package:greaticker/history/provider/history_provider.dart';
import 'package:greaticker/history/view/history_screen.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/home/provider/project_provider.dart';
import 'package:greaticker/home/view/home_screen.dart';
import 'package:greaticker/popular_chart/provider/popular_chart_provider.dart';
import 'package:greaticker/popular_chart/view/popular_chart_screen.dart';
import 'package:greaticker/profile/provider/profile_api_response_provider.dart';
import 'package:greaticker/profile/provider/profile_provider.dart';
import 'package:greaticker/profile/view/profile_screen.dart';
import 'package:greaticker/user/provider/auth_provider.dart';
import 'package:greaticker/user/provider/user_me_provider.dart';

import '../provider/auth/mock_auth_provider_with_loggined_uesr.dart';
import '../provider/auth/mock_auth_provider_with_no_loggined_uesr.dart';
import '../provider/hall_of_fame/api_response/mock_hall_of_fame_api_response_provider.dart';
import '../provider/home/project/api_response/mock_project_api_response_provider.dart';
import '../provider/home/project/mock_project_provider_returning_in_progress.dart';
import '../provider/home/sticker/mock_got_sticker_provider.dart';


final mockRouterWithNoLoggedInUserProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(mockAuthProviderWithNoLogginedUser);

  return GoRouter(
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirect,
      routes: [
        GoRoute(
          path: '/home',
          name: HomeScreen.routeName,
          pageBuilder: (_, state) => CustomTransitionPage(
              child: HomeScreen(
                key: HOME_SCREEN_KEY,
                projectProvider: mockProjectProviderReturningInProgress,
                projectApiResponseProvider: mockProjectApiResponseProvider,
                gotStickerProvider: mockGotStickerProvider,
                hallOfFameApiResponseProvider: mockHallOfFameApiResponseProvider,
                showPopUp: state.queryParameters[SHOW_POP_UP],
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // 애니메이션 없이 바로 전환
              },
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero),
          routes: [],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          pageBuilder: (_, state) => CustomTransitionPage(
              child: SplashScreen(
                key: SPLASH_SCREEN_KEY,
                userMeProvider: userMeProvider,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // 애니메이션 없이 바로 전환
              },
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero),
          routes: [],
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          pageBuilder: (_, state) => CustomTransitionPage(
              child: LoginScreen(
                key: LOGIN_SCREEN_KEY,
                userMeProvider: userMeProvider,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // 애니메이션 없이 바로 전환
              },
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero),
          routes: [],
        ),
      ]);
});
