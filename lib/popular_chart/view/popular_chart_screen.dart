import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/pagination_list_view.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/layout/default_layout.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/history/component/history_card.dart';
import 'package:greaticker/history/model/history_model.dart';
import 'package:greaticker/popular_chart/component/popular_chart_card.dart';
import 'package:greaticker/popular_chart/model/popular_chart_model.dart';



class PopularChartScreen extends StatelessWidget {
  static String get routeName => 'PopularChartScreen';

  final Key key;
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase> provider;

  const PopularChartScreen({
    required this.key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "popular_chart",
      child: PaginationListView<PopularChartModel>(
          provider: provider,
          itemBuilder: <PopularChartModel>(_, index, model) {
            return PopularChartCard.fromPopularChartModel(
              model: model,
            );
          }),
      language: dotenv.get(LANGUAGE),
    );
  }
}
