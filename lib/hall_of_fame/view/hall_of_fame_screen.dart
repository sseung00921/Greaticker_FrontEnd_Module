import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/component/pagination_list_view.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/layout/default_layout.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/hall_of_fame/component/hall_of_fame_card.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_request_dto.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hit_good_to_project_request_dto.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';

class HallOfFameScreen extends ConsumerStatefulWidget {
  static String get routeName => 'HallOfFameScreen';

  final Key key;
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase> provider;

  const HallOfFameScreen({
    required this.key,
    required this.provider,
  }) : super(key: key);

  @override
  HallOfFameScreenState createState() => HallOfFameScreenState();
}

class HallOfFameScreenState extends ConsumerState<HallOfFameScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      key: DEFAULT_LAYOUT_KEY,
      title_key: "hall_of_fame",
      child: PaginationListView<HallOfFameModel>(
        provider: widget.provider,
        itemBuilder: <HallOfFameModel>(_, index, model) {
          return HallOfFameCard.fromHallOfFameModel(
            model: model,
          );
        },
      ),
      language: dotenv.get(LANGUAGE),
    );
  }

  void actionToDoWhenHallOfFameDeleteIconWasPressed(String hallOfFameModelId) async {
    HallOfFameRequestDto hallOfFameRequestDto = HallOfFameRequestDto(
        projectId: hallOfFameModelId);
    final responseState = await ref
        .read(hallOfFameApiResponseProvider.notifier)
        .deleteHallOfFame(hallOfFameRequestDto: hallOfFameRequestDto, context: context);
    if (responseState is ApiResponseError ||
        responseState is ApiResponse && !responseState.isSuccess) {
      showOnlyCloseDialog(
        context: context,
        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
      );
    } else if (responseState is ApiResponse && responseState.isSuccess) {
      showOnlyCloseDialog(
          context: context,
          comment: COMMENT_DICT[dotenv.get(
              LANGUAGE)]![
          'delete_hall_of_fame_complete']!
      );
    };
  }

  void actionToDoWhenHallOfFameHitGoodIconWasPressed(String hallOfFameModelId) async {
    HitGoodToProjectRequestDto hitGoodToProjectRequestDto = HitGoodToProjectRequestDto(
        projectId: hallOfFameModelId);
    final responseState = await ref
        .read(hallOfFameApiResponseProvider.notifier)
        .hitGoodToHallOfFame(hitGoodToProjectRequestDto: hitGoodToProjectRequestDto, context: context);
    if (responseState is ApiResponseError ||
        responseState is ApiResponse && !responseState.isSuccess) {
      showOnlyCloseDialog(
        context: context,
        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
      );
    } else if (responseState is ApiResponse && responseState.isSuccess) {
      print("hit good was successed.");
    };
  }
}
