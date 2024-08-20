import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:greaticker/profile/repository/mock_profile_repositry.dart';
import 'package:greaticker/profile/repository/profile_repository.dart';

final profileApiResponseProvider =
StateNotifierProvider<ProfileApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockProfileRepositoryProvider);

  return ProfileApiResponseStateNotifier(repository: repo);
});

class ProfileApiResponseStateNotifier extends StateNotifier<ApiResponseBase> {

  final ProfileRepositoryBase repository;

  ProfileApiResponseStateNotifier({required this.repository}) : super(ApiResponseLoading());


  Future<void> changeNickname({required ChangeNicknameRequestDto changeNicknameRequestDto}) async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.changeNickname(changeNicknameRequestDto: changeNicknameRequestDto);
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  Future<void> logOut() async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.logOut();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  Future<void> deleteAccount() async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.deleteAccount();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }
}