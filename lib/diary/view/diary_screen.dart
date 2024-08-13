import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';

import '../../common/layout/default_layout.dart';


class DiaryScreen extends StatelessWidget {
  static String get routeName => 'DiaryScreen';

  final Key key;

  const DiaryScreen({
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "diary",
      child: Center(
        child: Text(
          'DiaryScreen',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      language: dotenv.get(LANGUAGE),
    );
  }
}