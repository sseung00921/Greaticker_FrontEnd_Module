import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/diary/component/diary_grid_list_view.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';

import '../../common/layout/default_layout.dart';


class DiaryScreen extends StatelessWidget {
  static String get routeName => 'DiaryScreen';
  final StateNotifierProvider<DiaryStateNotifier, DiaryModelBase> provider;

  final Key key;

  const DiaryScreen({
    required this.key,
    required this.provider,
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
          child: DiaryGridListView(provider: provider),
        ),
      ),
      language: dotenv.get(LANGUAGE),
    );
  }
}