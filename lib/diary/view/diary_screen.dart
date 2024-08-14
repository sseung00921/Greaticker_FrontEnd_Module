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
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/diary/background_book.png'),
              fit: BoxFit.cover, // 이미지의 크기를 컨테이너에 맞춤
            ),
          ),
          child: Center(
            child: Text(
              'DiaryScreen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      language: dotenv.get(LANGUAGE),
    );
  }
}