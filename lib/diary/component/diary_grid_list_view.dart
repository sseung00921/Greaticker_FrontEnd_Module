import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/language/stickers.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/common/utils/url_builder_utils.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/model/request_dto/diary_model_request_dto.dart';
import 'package:greaticker/diary/model/request_dto/hit_favorite_to_sticker_reqeust_dto.dart';
import 'package:greaticker/diary/provider/diary_api_response_provider.dart';
import 'package:greaticker/diary/provider/diary_provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class DiaryGridListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<DiaryStateNotifier, ApiResponseBase> provider;

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

    if (state is ApiResponseLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (state is ApiResponseError) {
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

    state as ApiResponse;
    final diaryState = state.data as DiaryModel;

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
          children: diaryState.stickerInventory
              .map((e) => GestureDetector(
              key: Key("StickerGestureDetector-${e}"),
              onTap: () {
                bool isFavorite = false;
                isFavorite = _showFilledFavoriteIconIfThisStickerIsInHitFavoriteList(diaryState, e, isFavorite);
                showStickerPopUpModal(context, e, isFavorite, diaryState);
              },
              child: Image.asset(
                  key: Key("Sticker-${e}"),
                  UrlBuilderUtils.imageUrlBuilderByStickerId(e))))
              .toList(),
          onReorder: (oldIndex, newIndex) async {
            setState(() {
              final element = diaryState.stickerInventory.removeAt(oldIndex);
              diaryState.stickerInventory.insert(newIndex, element);
            });
            DiaryModelRequestDto diaryModelRequestDto  = DiaryModelRequestDto(
                id: "1", stickerInventory: diaryState.stickerInventory, hitFavoriteList: diaryState.hitFavoriteList);
            final responseState = await ref
                .read(diaryApiResponseProvider.notifier)
                .updateDiaryModel(diaryModelRequestDto: diaryModelRequestDto, context: context);
            if (responseState is ApiResponseError ||
                responseState is ApiResponse && !responseState.isSuccess) {
              showOnlyCloseDialog(
                context: context,
                comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
              );
            } else if (responseState is ApiResponse && responseState.isSuccess)  {
              print("Sticker Order Change Was Successed.");
            };
          },
        ),
      ),
    );
  }

  void showStickerPopUpModal(BuildContext context, String stickerId, bool isFavorite, DiaryModel diaryState) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String stickerName = STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![stickerId]!["name"]!;
          String stickerDescription = STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![stickerId]!["description"]!;

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
                      key: Key("StickerPopUpModal-${stickerId}"),
                      UrlBuilderUtils.imageUrlBuilderByStickerId(
                          stickerId),
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
                          style: YeongdeokSeaTextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
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
                            style: YeongdeokSeaTextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
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
                                onPressed: () async {
                                    if (isFavorite) {
                                      isFavorite = await _actionToDoWhenFromFavoriteToNotFavorite(stickerId, context, diaryState, isFavorite);
                                    } else if (!isFavorite) {
                                      if (diaryState.hitFavoriteList.length < 3) {
                                        isFavorite = await _actionToDoWhenFromNotFavoriteToFavorite(stickerId, context, diaryState, isFavorite);
                                      } else if (diaryState.hitFavoriteList.length >= 3) {
                                        showDialog(context: context, builder: (BuildContext context) {
                                            return FavoriteStickerLimitOverAlertDialog();
                                          }
                                        );
                                      };
                                    }
                                    _controller.forward(from: 0.01);
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
  }

  bool _showFilledFavoriteIconIfThisStickerIsInHitFavoriteList(DiaryModel diaryModel, String e, bool isFavorite) {
    if (diaryModel.hitFavoriteList.contains(e)) {
      isFavorite = true;
    }
    return isFavorite;
  }

  Future<bool> _actionToDoWhenFromFavoriteToNotFavorite(String stickerId, BuildContext context, DiaryModel diaryState, bool isFavorite) async {
    HitFavoriteToStickerReqeustDto hitFavoriteToStickerReqeustDto = HitFavoriteToStickerReqeustDto(
        stickerId: stickerId);
    final responseState = await ref
        .read(diaryApiResponseProvider.notifier)
        .hitFavoriteToSticker(hitFavoriteToStickerReqeustDto: hitFavoriteToStickerReqeustDto, context: context);
    if (responseState is ApiResponseError ||
        responseState is ApiResponse && !responseState.isSuccess) {
      showOnlyCloseDialog(
        context: context,
        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
      );
    } else if (responseState is ApiResponse && responseState.isSuccess) {
      diaryState.hitFavoriteList.remove(stickerId);
      print(diaryState.hitFavoriteList);
      setState(() {
        isFavorite = !isFavorite;
      });
    };
    return isFavorite;
  }

  Future<bool> _actionToDoWhenFromNotFavoriteToFavorite(String stickerId, BuildContext context, DiaryModel diaryState, bool isFavorite) async {
    HitFavoriteToStickerReqeustDto hitFavoriteToStickerReqeustDto = HitFavoriteToStickerReqeustDto(
        stickerId: stickerId);
    final responseState = await ref
        .read(diaryApiResponseProvider.notifier)
        .hitFavoriteToSticker(hitFavoriteToStickerReqeustDto: hitFavoriteToStickerReqeustDto, context: context);
    if (responseState is ApiResponseError ||
        responseState is ApiResponse && !responseState.isSuccess) {
      showOnlyCloseDialog(
        context: context,
        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
      );
    } else if (responseState is ApiResponse && responseState.isSuccess)  {
      diaryState.hitFavoriteList.add(stickerId);
      print(diaryState.hitFavoriteList);
      setState(() {
        isFavorite = !isFavorite;
      });
    };
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
      content: Text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['can_not_register_favorite_sticker_more_than_3']!,
        style: YeongdeokSeaTextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),),
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
