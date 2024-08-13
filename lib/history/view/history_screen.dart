import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';

import '../../common/layout/default_layout.dart';


class HistoryScreen extends StatelessWidget {
  static String get routeName => 'HistoryScreen';

  final Key key;

  const HistoryScreen({
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "history",
      child: Center(
        child: Text(
          'HistoryScreen',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      language: dotenv.get(LANGUAGE),
    );
  }
}