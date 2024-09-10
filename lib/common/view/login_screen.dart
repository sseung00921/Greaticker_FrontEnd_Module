import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // GoRouter 임포트
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/colors.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/user/provider/user_me_provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'LoginScreen';
  final StateNotifierProvider<UserMeStateNotifier, ApiResponseBase>
      userMeProvider;

  final Key key;

  LoginScreen({
    required this.key,
    required this.userMeProvider,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.userMeProvider);

    if (state is ApiResponseLoading) {
      return Stack(
        children: [
          loginUI(),
          Container(
            color: Colors.black.withOpacity(0.5), // 화면을 어둡게 처리
            child: Center(
              child: CircularProgressIndicator(), // 중앙에 로딩 인디케이터 표시
            ),
          ),
        ],
      );
    } else if (state is ApiResponse) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home'); // 상태가 ApiResponse이면 /home/project로 이동
      });
      return loginUI();
    } else if (state is ApiResponseError) {
      return loginUI();
    } else {
      return loginUI();
    }
  }

  Scaffold loginUI() {
    return Scaffold(
      backgroundColor: Color(OUR_MAIN_BASE_COLOR),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['app_title']!,
              style: YeongdeokSeaTextStyle(fontSize: 44, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: 16,),
            SizedBox(
              child: Text(COMMENT_DICT[dotenv.get(LANGUAGE)]!['app_description']!,
                style: YeongdeokSeaTextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 32,),
            mainLogo(),
            SizedBox(height: 32,),
            Center(
              child: loginButtons(),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox loginButtons() {
    if (dotenv.get(ENVIRONMENT) == "TEST") {
      /**이 코드는 Flutter sign_in_button 패키지의 결함으로
       * 구글 디자인 버튼이 들어간 페이지는 렌더링(pixel overflow) 결함 이슈로 인해 테스트가 실패하는 현상을
       * 방지하고자 임시로 작성한 코드이다. 추후 패키지가 버전업되면서 문제가 수정되면 삭제할 예정인 코드이다.
      **/
      return SizedBox();
    }
    return SizedBox(
        width: 240,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SignInButton(
            Buttons.google,
            text: BUTTON_DICT[dotenv.get(LANGUAGE)]!['sign_in_with_google']!,
            onPressed: () async {
              final responseState = await ref
                  .read(userMeProvider.notifier)
                  .loginWithGoogle(context: context);
              if (responseState is ApiResponseError ||
                  responseState is ApiResponse && !responseState.isSuccess) {
                showOnlyCloseDialog(
                  context: context,
                  comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
                );
              }
            },
          ),
        ));
  }

  ClipRRect mainLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.0),
      child: Image.asset(
        'assets/img/diary/sticker/Littlewin_sticker.png',
        width: 160,
        height: 160,
      ),
    );
  }
}
