import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod 패키지 임포트
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/user/provider/user_me_provider.dart';
import 'package:go_router/go_router.dart'; // GoRouter 임포트

class SplashScreen extends ConsumerStatefulWidget {
  static String get routeName => 'SplashScreen';

  final Key key;
  final StateNotifierProvider<UserMeStateNotifier,
      ApiResponseBase> userMeProvider;

  SplashScreen({
    required this.key,
    required this.userMeProvider,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 필요한 초기화 작업 수행
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.userMeProvider); // yourUserMeProvider는 주입된 Riverpod 프로바이더입니다.
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          if (state is ApiResponseLoading) {
            return Stack(
              children: [
                Center(
                  child: mainLogo(),
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          } else if (state is ApiResponse) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/home');
            });
            return Center(
              child: mainLogo(),
            );
          } else if (state is ApiResponseError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');
            });
            return Center(
              child: mainLogo(),
            );
          } else {
            return Center(
              child: mainLogo(),
            );
          }
        },
      ),
    );
  }

  ClipRRect mainLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.0),
      child: Image.asset(
                    'assets/img/diary/sticker/Littlewin_sticker.png',
                    width: 200,
                    height: 200,
                  ),
    );
  }
}
