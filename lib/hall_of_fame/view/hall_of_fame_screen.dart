import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/pagination_list_view.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/layout/default_layout.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/component/hall_of_fame_card.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_provider.dart';


class HallOfFameScreen extends StatelessWidget {
  static String get routeName => 'HallOfFameScreen';

  final Key key;
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase> provider;

  const HallOfFameScreen({
    required this.key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "hall_of_fame",
      child: PaginationListView<HallOfFameModel>(
          provider: provider,
          itemBuilder: <HallOfFameModel>(_, index, model) {
            return HallOfFameCard.fromHallOfFameModel(
              model: model,
            );
          }),
      language: dotenv.get(LANGUAGE),
    );
  }
}
