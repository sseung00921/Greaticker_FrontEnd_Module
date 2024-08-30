import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String get routeName => 'SplashScreen';

  final Key key;

  SplashScreen({
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: Center(
        child: Image.asset(
          'assets/img/diary/sticker/Littlewin_sticker.png', // 이미지 경로
          width: 200, // 이미지 너비 조정 (필요시)
          height: 200, // 이미지 높이 조정 (필요시)
        ),
      ),
    );
  }
}