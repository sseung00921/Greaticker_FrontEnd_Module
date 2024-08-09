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
    index: 0,
  ),
  TabInfo(
    icon: Icons.book, // 다이어리 모양 아이콘
    label_key: 'diary',
    index: 1,
  ),
  TabInfo(
    icon: Icons.library_books, // 명예의 전당 모양 아이콘
    label_key: 'hall_of_fame',
    index: 2,
  ),
  TabInfo(
    icon: Icons.bar_chart,
    label_key: 'popular_chart',
    index: 3,
  ),
];

const TOP_TABS = [
  TabInfo(
    icon: Icons.access_time, // 시계모양 아이콘
    label_key: 'history',
    index: 4,
  ),
  TabInfo(
    icon: Icons.settings, // 설정모양 아이콘
    label_key: 'profile',
    index: 5,
  ),
];