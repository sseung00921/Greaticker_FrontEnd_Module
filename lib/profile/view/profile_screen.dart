import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/profile/component/profile_view.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/provider/profile_provider.dart';

import '../../common/layout/default_layout.dart';


class ProfileScreen extends StatelessWidget {
  static String get routeName => 'ProfileScreen';
  
  final Key key;
  final StateNotifierProvider<ProfileStateNotifier, ProfileModelBase> provider;

  const ProfileScreen({
    required this.key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "profile",
      child: ProfileView(profileProvider: provider),
      language: dotenv.get(LANGUAGE),
    );
  }
}