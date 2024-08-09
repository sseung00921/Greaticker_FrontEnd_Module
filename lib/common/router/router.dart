
import 'package:go_router/go_router.dart';

import '../../diary/screen/diary_screen.dart';
import '../../hall_of_fame/screen/hall_of_fame_screen.dart';
import '../../history/screen/history_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../poppular_chart/screen/popular_chart_screen.dart';
import '../../profile/screen/profile_screen.dart';
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