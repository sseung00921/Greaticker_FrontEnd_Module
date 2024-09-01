import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:go_router/go_router.dart'; // GoRouter 임포트
import 'package:greaticker/user/provider/user_me_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'LoginScreen';
  final StateNotifierProvider<UserMeStateNotifier, ApiResponseBase> userMeProvider;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: loginButtons(),
        ),
      ),
    );
  }

  SizedBox loginButtons() {
    return SizedBox(
                width: 240,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final responseState = await ref.read(userMeProvider.notifier).loginWithGoogle(context: context);
                    if (responseState is ApiResponseError ||
                        responseState is ApiResponse && !responseState.isSuccess) {
                      showOnlyCloseDialog(
                        context: context,
                        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                        'network_error']!,
                      );
                    }
                  },
                  //ref.read(userMeProvider.notifier).loginWithGoogle,
                  icon: Icon(Icons.login),
                  label: Text(
                    BUTTON_DICT[dotenv.get(LANGUAGE)]!['sign_in_with_google']!,
                    style: YeongdeokSeaTextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // 버튼 색상
                  ),
                ),
              );
  }
}
