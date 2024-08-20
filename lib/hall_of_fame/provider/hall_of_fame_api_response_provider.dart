import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_request_dto.dart';
import 'package:greaticker/hall_of_fame/repository/hall_of_fame_repository.dart';
import 'package:greaticker/hall_of_fame/repository/mock_hall_of_fame_repository.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:greaticker/profile/repository/mock_profile_repositry.dart';
import 'package:greaticker/profile/repository/profile_repository.dart';

final hallOfFameApiResponseProvider =
StateNotifierProvider<HallOfFameApiResponseStateNotifier, ApiResponseBase>((ref) {
  final repo = ref.watch(MockHallOfFameRepositoryProvider);

  return HallOfFameApiResponseStateNotifier(repository: repo);
});

class HallOfFameApiResponseStateNotifier extends StateNotifier<ApiResponseBase> {

  final MockHallOfFameRepository repository;

  HallOfFameApiResponseStateNotifier({required this.repository}) : super(ApiResponseLoading());


  Future<void> registerHallOfFame({required HallOfFameRequestDto hallOfFameRequestDto}) async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.registerHallOfFame(hallOfFameRequestDto: hallOfFameRequestDto);
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }

  Future<void> reviseHallOfFamePrivacyPolice({required HallOfFameRequestDto hallOfFameRequestDto}) async {
    try {
      state = ApiResponseLoading();
      final resp = await repository.reviseHallOfFamePrivacyPolice(hallOfFameRequestDto: hallOfFameRequestDto);
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);
      state = ApiResponseError(message: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!);
    }
  }
}