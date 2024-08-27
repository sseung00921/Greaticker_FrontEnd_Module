import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';
import 'package:greaticker/home/component/home_view.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/home/provider/project_provider.dart';

import '../../common/layout/default_layout.dart';

class HomeScreen extends StatelessWidget {
  static String get routeName => 'HomeScreen';

  final Key key;
  final StateNotifierProvider<ProjectStateNotifier, ApiResponseBase>
      projectProvider;
  final StateNotifierProvider<ProjectApiResponseStateNotifier, ApiResponseBase>
      projectApiResponseProvider;
  final StateNotifierProvider<GotStickerStateNotifier, ApiResponseBase>
      gotStickerProvider;
  final StateNotifierProvider<HallOfFameApiResponseStateNotifier, ApiResponseBase>
    hallOfFameApiResponseProvider;
  final String? showPopUp;

  const HomeScreen({
    required this.key,
    required this.projectProvider,
    required this.projectApiResponseProvider,
    required this.gotStickerProvider,
    required this.hallOfFameApiResponseProvider,
    this.showPopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "home",
      child: HomeView(
        projectProvider: projectProvider,
        projectApiResponseProvider: projectApiResponseProvider,
        gotStickerProvider: gotStickerProvider,
        hallOfFameApiResponseProvider: hallOfFameApiResponseProvider,
        showPopUp: showPopUp,
      ),
      language: dotenv.get(LANGUAGE),
    );
  }
}
