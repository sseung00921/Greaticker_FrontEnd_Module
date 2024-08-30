import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/common.dart';

class LoginScreen extends StatelessWidget {
  static String get routeName => 'LoginScreen';

  final Key key;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginScreen({
    required this.key,
  }) : super(key: key);

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // 로그인 성공 후 처리할 로직
      print("Google 로그인 성공");
    } catch (error) {
      print("Google 로그인 실패: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 240,
            child: ElevatedButton.icon(
              onPressed: _handleGoogleSignIn,
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
          ),
        ),
      ),
    );
  }
}
