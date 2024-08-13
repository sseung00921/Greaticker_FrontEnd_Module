import 'package:go_router/go_router.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/diary/view/diary_screen.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_provider.dart';
import 'package:greaticker/hall_of_fame/view/hall_of_fame_screen.dart';
import 'package:greaticker/history/view/history_screen.dart';
import 'package:greaticker/home/view/home_screen.dart';
import 'package:greaticker/poppular_chart/view/popular_chart_screen.dart';
import 'package:greaticker/profile/view/profile_screen.dart';

final router = GoRouter(initialLocation: '/home', routes: [
  GoRoute(
    path: '/home',
    name: HomeScreen.routeName,
    pageBuilder: (_, state) => CustomTransitionPage(
        child: HomeScreen(key: HOME_SCREEN_KEY),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 없이 바로 전환
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero),
    builder: (_, state) => HomeScreen(key: HOME_SCREEN_KEY),
    routes: [],
  ),
  GoRoute(
    path: '/diary',
    name: DiaryScreen.routeName,
    pageBuilder: (_, state) => CustomTransitionPage(
        child: DiaryScreen(key: DIARY_SCREEN_KEY),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 없이 바로 전환
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero),
    routes: [],
  ),
  GoRoute(
    path: '/hall-of-fame',
    name: HallOfFameScreen.routeName,
    pageBuilder: (_, state) => CustomTransitionPage(
        child: HallOfFameScreen(key: HALL_OF_FAME_SCREEN_KEY, provider: hallOfFameProvider,),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 없이 바로 전환
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero),
    routes: [],
  ),
  GoRoute(
    path: '/popular-chart',
    name: PopularChartScreen.routeName,
    pageBuilder: (_, state) => CustomTransitionPage(
        child: PopularChartScreen(key: POPULAR_CHART_SCREEN_KEY),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 없이 바로 전환
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero),
    routes: [],
  ),
  GoRoute(
    path: '/history',
    name: HistoryScreen.routeName,
    pageBuilder: (_, state) => CustomTransitionPage(
        child: HistoryScreen(key: HISTORY_SCREEN_KEY),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 없이 바로 전환
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero),
    routes: [],
  ),
  GoRoute(
    path: '/profile',
    name: ProfileScreen.routeName,
    pageBuilder: (_, state) => CustomTransitionPage(
        child: ProfileScreen(key: PROFILE_SCREEN_KEY),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 없이 바로 전환
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero),
    routes: [],
  ),
]);
