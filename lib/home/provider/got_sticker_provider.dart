import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/model/requestDto/project_request_dto.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final gotStickerProvider =
StateNotifierProvider<GotStickerStateNotifier, GotStickerModelBase>((ref) {
  final repo = ref.watch(ProjectRepositoryProvider);

  return GotStickerStateNotifier(repository: repo);
});

class GotStickerStateNotifier extends StateNotifier<GotStickerModelBase> {

  final ProjectRepositoryBase repository;

  GotStickerStateNotifier({required this.repository}) : super(GotStickerModelLoading());


  Future<void> getProjectModel() async {
    try {
      final resp = await repository.getNewSticker();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = GotStickerModelError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}