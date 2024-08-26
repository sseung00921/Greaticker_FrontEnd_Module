import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/component/modal/yes_no_modal.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/error_message/error_message.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/params.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/utils/api_utils.dart';
import 'package:greaticker/profile/model/profile_model.dart';
import 'package:greaticker/profile/model/request_dto/change_nickname_request_dto.dart';
import 'package:greaticker/profile/provider/profile_api_response_provider.dart';
import 'package:greaticker/profile/provider/profile_provider.dart';

// ProfileScreen 위젯
class ProfileView extends ConsumerStatefulWidget {
  final StateNotifierProvider<ProfileStateNotifier, ApiResponseBase>
      profileProvider;
  final StateNotifierProvider<ProfileApiResponseStateNotifier, ApiResponseBase>
      profileApiResponseProvider;

  const ProfileView({
    Key? key,
    required this.profileProvider,
    required this.profileApiResponseProvider,
  }) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.profileProvider);

    // 완전 처음 로딩일때
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
              ref.read(widget.profileProvider.notifier).getProfileModel();
            },
            child: Text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!),
          ),
        ],
      );
    }

    state as ApiResponse;
    final profileState = state.data as ProfileModel;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 그림자 색상
                      spreadRadius: 5, // 그림자가 퍼지는 정도
                      blurRadius: 7, // 그림자의 흐림 정도
                      offset: Offset(3, 3), // 그림자의 위치 (x축, y축)
                    ),
                  ],
                ),
                width: 228,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      hintText: profileState.userNickname,
                    ), // 텍스트 인풋 비활성화
                  ),
                ),
              ),
              SizedBox(width: 10),
              // 닉네임 변경 버튼
              Container(
                width: 124,
                child: ElevatedButton(
                  onPressed: () async {
                    String newNickname = _nicknameController.text;

                    final responseState = await ref
                        .read(widget.profileApiResponseProvider.notifier)
                        .changeNickname(
                          changeNicknameRequestDto: ChangeNicknameRequestDto(
                              newNickname: newNickname),
                          context: context,
                        );
                    if (responseState is ApiResponseError ||
                        responseState is ApiResponse && !responseState.isSuccess) {
                      if (responseState is ApiResponse && responseState.messeage == DUPLICATED_NICKNAME) {
                        print("aaaaa");
                        showOnlyCloseDialog(
                          context: context,
                          comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                          'duplicated_nickname']!,
                        );
                      } else {
                        showOnlyCloseDialog(
                          context: context,
                          comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                          'network_error']!,
                        );
                      }
                    } else if (responseState is ApiResponse && responseState.isSuccess) {
                      responseState as ApiResponse<String>;
                      if (responseState.isSuccess) {
                        showOnlyCloseDialog(
                          context: context,
                          comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                          'change_nickname_completed']!,
                        );
                      }
                    }
                  },
                  child: Text(
                    BUTTON_DICT[dotenv.get(LANGUAGE)]!['change_nickname']!,
                    style: YeongdeokSeaTextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // 로그아웃 버튼
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                final responseState = await ref.read(profileApiResponseProvider.notifier).logOut(context: context);
                if (responseState is ApiResponseError ||
                    responseState is ApiResponse && !responseState.isSuccess) {
                  showOnlyCloseDialog(
                    context: context,
                    comment:
                        COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
                  );
                } else if (responseState is ApiResponse &&
                    responseState.isSuccess) {
                  context.go("/home?${SHOW_POP_UP}=${LOG_OUT_COMPLETE}");
                }
              },
              child: Text(
                BUTTON_DICT[dotenv.get(LANGUAGE)]!['log_out']!,
                style: YeongdeokSeaTextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 10),
          // 회원 탈퇴 버튼
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                showYesNoDialog(
                  context: context,
                  comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                      'delete_account_try']!,
                  onYes: () async {
                    final responseState = await ref
                        .read(profileApiResponseProvider.notifier)
                        .deleteAccount(context: context);
                    if (responseState is ApiResponseError ||
                        responseState is ApiResponse && !responseState.isSuccess) {
                      showOnlyCloseDialog(
                        context: context,
                        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                            'network_error']!,
                      );
                    } else if (responseState is ApiResponse &&
                        responseState.isSuccess) {
                      context.go(
                          "/home?${SHOW_POP_UP}=${DELETE_ACCOUNT_COMPLETE}");
                    }
                  },
                );
              },
              child: Text(
                BUTTON_DICT[dotenv.get(LANGUAGE)]!['delete_account']!,
                style: YeongdeokSeaTextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 10),
          // 튜토리얼 보기 버튼
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                // 튜토리얼 보기 로직
                print('View Tutorial button pressed');
              },
              child: Text(
                BUTTON_DICT[dotenv.get(LANGUAGE)]!['view_tutorial']!,
                style: YeongdeokSeaTextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
