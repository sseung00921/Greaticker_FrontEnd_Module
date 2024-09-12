import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greaticker/common/constants/error_message/error_message.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/router/router.dart';
import 'package:greaticker/user/provider/user_me_provider.dart';

import '../constants/data.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  // 1) 요청을 보낼때
  // 요청이 보내질때마다
  // 만약에 요청의 Header에 accessToken: true라는 값이 있다면
  // 실제 토큰을 가져와서 (storage에서) authorization: bearer $token으로
  // 헤더를 변경한다.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: JWT_TOKEN);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //에러가 났을 때 인증이슈이면 다시 로그인 화면으로 보내기 위함.
    //401 UnAuthorized, 403 Forbidden
    int statusCode = err.response?.statusCode ?? 0;
    if (statusCode == 401 || statusCode == 403) {
      ref.read(userMeProvider.notifier).setErrorState();
      ref.read(routerProvider).go("/login");
    }

    return handler.reject(err);
  }
}
