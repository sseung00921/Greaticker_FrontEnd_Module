import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/fonts.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/language/stickers.dart';
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
  ConsumerState<DiaryGridListView> createState() =>
      _DiaryGridListViewState<T>();
}

class _DiaryGridListViewState<T extends IModelWithId>
    extends ConsumerState<DiaryGridListView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            child: Text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!),
          ),
        ],
      );
    }

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
          children: diaryModel.stickerInventory
              .map((e) => GestureDetector(
              key: Key("StickerGestureDetector-${e}"),
              onTap: () {
                bool isFavorite = false;
                isFavorite = _showFilledFavoriteIconIfThisStickerIsInHitFavoriteList(diaryModel, e, isFavorite);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String stickerName = STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![e]!["name"]!;
                      String stickerDescription = STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![e]!["description"]!;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white38,
                                      width: 4), // 은색 테두리
                                ),
                                child: Image.asset(
                                  key: Key("StickerPopUpModal-${e}"),
                                  UrlBuilderUtils.imageUrlBuilderByStickerId(
                                      e),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0), // 둥근 모서리
                                border: Border.all(
                                  color: Colors.black38, // 테두리 색상
                                  width: 3.0, // 테두리 두께
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      stickerName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: YEONGDEOK_SEA,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        stickerDescription,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: YEONGDEOK_SEA,
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: AnimatedBuilder(
                                      animation: _controller,
                                      builder: (context, child) {
                                        return Transform.rotate(
                                          angle: _controller.value * 2.0 * 3.141592653589793, // 360도 회전
                                          child: IconButton(
                                            icon: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border_outlined,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (isFavorite) {
                                                  diaryModel.hitFavoriteList.remove(e);
                                                  isFavorite = !isFavorite;
                                                } else if (!isFavorite) {
                                                  if (diaryModel.hitFavoriteList.length < 3) {
                                                    diaryModel.hitFavoriteList.add(e);
                                                    isFavorite = !isFavorite;
                                                  } else if (diaryModel.hitFavoriteList.length >= 3) {
                                                    showDialog(context: context, builder: (BuildContext context) {
                                                        return FavoriteStickerLimitOverAlertDialog();
                                                      }
                                                    );
                                                  };
                                                }
                                                _controller.forward(from: 0.01);
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Image.asset(
                  key: Key("Sticker-${e}"),
                  UrlBuilderUtils.imageUrlBuilderByStickerId(e))))
              .toList(),
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

  bool _showFilledFavoriteIconIfThisStickerIsInHitFavoriteList(DiaryModel diaryModel, String e, bool isFavorite) {
    if (diaryModel.hitFavoriteList.contains(e)) {
      isFavorite = true;
    }
    return isFavorite;
  }
}

class FavoriteStickerLimitOverAlertDialog extends StatelessWidget {
  const FavoriteStickerLimitOverAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['can_not_register_favorite_sticker_more_than_3']!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          fontFamily: YEONGDEOK_SEA,
        ),),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
