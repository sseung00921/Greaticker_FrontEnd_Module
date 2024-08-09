
import 'package:go_router/go_router.dart';

import '../../diary/view/diary_screen.dart';
import '../../hall_of_fame/view/hall_of_fame_screen.dart';
import '../../history/view/history_screen.dart';
import '../../home/view/home_screen.dart';
import '../../poppular_chart/view/popular_chart_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../constants/widget_keys.dart';

final router = GoRouter(
    initialLocation: '/home',
    routes:
  [
    GoRoute(
      path: '/home',
      name: HomeScreen.routeName,
      builder: (_, state) => HomeScreen(key:  HOME_SCREEN_KEY),
      routes: [
      ],
    ),
    GoRoute(
      path: '/diary',
      name: DiaryScreen.routeName,
      builder: (_, state) => DiaryScreen(key:  DIARY_SCREEN_KEY),
      routes: [
      ],
    ),
    GoRoute(
      path: '/hall-of-fame',
      name: HallOfFameScreen.routeName,
      builder: (_, state) => HallOfFameScreen(key:  HALL_OF_FAME_SCREEN_KEY),
      routes: [
      ],
    ),
    GoRoute(
      path: '/popular-chart',
      name: PopularChartScreen.routeName,
      builder: (_, state) => PopularChartScreen(key:  POPULAR_CHART_SCREEN_KEY),
      routes: [
      ],
    ),
    GoRoute(
      path: '/history',
      name: HistoryScreen.routeName,
      builder: (_, state) => HistoryScreen(key:  HISTORY_SCREEN_KEY),
      routes: [
      ],
    ),
    GoRoute(
      path: '/profile',
      name: ProfileScreen.routeName,
      builder: (_, state) => ProfileScreen(key:  PROFILE_SCREEN_KEY),
      routes: [
      ],
    ),
  ]
);