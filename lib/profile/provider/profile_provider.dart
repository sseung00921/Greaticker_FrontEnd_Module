import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/provider/profile_api_response_provider.dart';
import 'package:greaticker/profile/repository/mock_profile_repositry.dart';
import 'package:greaticker/profile/repository/profile_repository.dart';

final profileProvider =
StateNotifierProvider<ProfileStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProfileRepositoryProvider);
  final notifier = ProfileStateNotifier(repository: repo);

  ref.listen<ApiResponseBase>(profileApiResponseProvider, (previous, next) {
    if (next is ApiResponseLoading) {
      notifier.setLoadingState();
    } else if (next is ApiResponseError) {
      notifier.setErrorState();
    } else {
      //이 코드는 백엔드 개발까지 구현된 직후 다시 주석을 해제해야함 ToBeOpened
      notifier.getProfileModel();
    };
  });

  return notifier;
});

class ProfileStateNotifier extends StateNotifier<ApiResponseBase> {
  final ProfileRepositoryBase repository;

  ProfileStateNotifier({required this.repository}) : super(ApiResponseLoading()) {
    getProfileModel();
  }

  Future<void> getProfileModel() async {
    try {
      final resp = await repository.getProfileModel();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  void setLoadingState() {
    state = ApiResponseLoading();
  }

  void setErrorState() {
    state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
  }
}
