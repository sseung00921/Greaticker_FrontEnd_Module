import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/repository/mock_project_repository.dart';
import 'package:greaticker/home/repository/project_repository.dart';

final gotStickerProvider =
StateNotifierProvider<GotStickerStateNotifier, GotStickerModelBase>((ref) {
  final repo = ref.watch(MockProjectRepositoryProvider);

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
      state = GotStickerModelError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }
}