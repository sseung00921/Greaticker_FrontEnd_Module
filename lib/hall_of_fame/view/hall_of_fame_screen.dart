import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/hall_of_fame/component/hall_of_fame_card.dart';

import '../../common/layout/default_layout.dart';

class HallOfFameScreen extends StatelessWidget {
  static String get routeName => 'HallOfFameScreen';

  final Key key;

  const HallOfFameScreen({
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "hall_of_fame",
      child: Column(children: [
        HallOfFameCard(
            key: Key("hallOfFameCard"),
            id: "123",
            userNickName: "뾰롱이",
            accomplishedDate: "2024-08-12",
            accomplishedTopic: "간호조무사 시험 공부",
            likeCount: 123)
      ]),
      language: dotenv.get('LANGUAGE'),
    );
  }
}
