import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/common/provider/pagination_provider.dart';
import 'package:greaticker/common/utils/pagination_utils.dart';
import 'package:greaticker/common/utils/url_builder_utils.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';


class DiaryGridListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<DiaryStateNotifier, DiaryModelBase> provider;

  const DiaryGridListView({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  ConsumerState<DiaryGridListView> createState() => _DiaryGridListViewState<T>();
}

class _DiaryGridListViewState<T extends IModelWithId> extends ConsumerState<DiaryGridListView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    // 완전 처음 로딩일때
    if (state is DiaryModelLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (state is DiaryModelError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).getDiaryModel();
            },
            child: Text(
              BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!
            ),
          ),
        ],
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    final diaryModel = state as DiaryModel;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(widget.provider.notifier).getDiaryModel();
        },
        child: ReorderableGridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: diaryModel.stickerInventory.map((e) => Image.asset(key: Key("Sticker-${e}"), UrlBuilderUtils.imageUrlBuilderByStickerId(e))).toList(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              final element = diaryModel.stickerInventory.removeAt(oldIndex);
              diaryModel.stickerInventory.insert(newIndex, element);
            });
          },
        ),
      ),
    );
  }
}
