import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/constants/widget_keys.dart';

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
      child: Center(
        child: Text(
          'HallOfFameScreen',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      language: dotenv.get('LANGUAGE'),
    );
  }
}