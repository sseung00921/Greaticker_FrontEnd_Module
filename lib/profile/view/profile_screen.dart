import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/constants/widget_keys.dart';

import '../../common/layout/default_layout.dart';


class ProfileScreen extends StatelessWidget {
  static String get routeName => 'ProfileScreen';
  
  final Key key;

  const ProfileScreen({
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "profile",
      child: Center(
        child: Text(
          'ProfileScreen',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      language: dotenv.env['LANGUAGE']!,
    );
  }
}