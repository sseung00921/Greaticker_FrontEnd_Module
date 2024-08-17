import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/home/component/home_view.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/project_provider.dart';

import '../../common/layout/default_layout.dart';


class HomeScreen extends StatelessWidget {
  static String get routeName => 'HomeScreen';

  final Key key;
  final StateNotifierProvider<ProjectStateNotifier, ProjectModelBase> provider;

  const HomeScreen({
    required this.key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "home",
      child: HomeView(provider: provider,),
      language: dotenv.get(LANGUAGE),
    );
  }
}