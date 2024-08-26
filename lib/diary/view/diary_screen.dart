import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/component/diary_grid_list_view.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/model/request_dto/hit_favorite_to_sticker_reqeust_dto.dart';
import 'package:greaticker/diary/provider/diary_api_response_provider.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';

import '../../common/layout/default_layout.dart';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryScreen extends ConsumerStatefulWidget {
  static String get routeName => 'DiaryScreen';

  final Key key;
  final StateNotifierProvider<DiaryStateNotifier, ApiResponseBase> provider;

  const DiaryScreen({
    required this.key,
    required this.provider,
  }) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
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
          child: DiaryGridListView(provider: widget.provider),
        ),
      ),
      language: dotenv.get(LANGUAGE),
    );
  }
}
