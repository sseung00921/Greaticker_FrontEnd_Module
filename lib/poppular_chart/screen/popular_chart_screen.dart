import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/constants/widget_keys.dart';
import '../../common/layout/default_layout.dart';


class PopularChartScreen extends StatelessWidget {
  static String get routeName => 'PopularChartScreen';

  final Key key;

  const PopularChartScreen({
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "popular_chart",
      child: Center(
        child: Text(
          'PopularChartScreen',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      language: dotenv.get('LANGUAGE'),
    );
  }
}