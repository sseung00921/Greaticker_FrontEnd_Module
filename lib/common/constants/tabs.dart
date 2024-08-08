import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label_key;
  final int? index;

  const TabInfo({
    required this.icon,
    required this.label_key,
    this.index
  });
}

const BOTTOM_TABS = [
  TabInfo(
    icon: Icons.home, // 홈 아이콘
    label_key: 'home',
  ),
  TabInfo(
    icon: Icons.book, // 다이어리 모양 아이콘
    label_key: 'diary',
  ),
  TabInfo(
    icon: Icons.library_books, // 명예의 전당 모양 아이콘
    label_key: 'hall_of_fame',
  ),
  TabInfo(
    icon: Icons.bar_chart,
    label_key: 'popular_charts',
  ),
];

const TOP_TABS = [
  TabInfo(
    icon: Icons.access_time, // 홈 아이콘
    label_key: 'history',
    index: 0,
  ),
  TabInfo(
    icon: Icons.settings, // 다이어리 모양 아이콘
    label_key: 'profile',
    index: 1,
  ),
];