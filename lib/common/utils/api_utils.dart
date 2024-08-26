import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/model/api_response.dart';

class ApiUtils {
  static void handleApiResponse({
    required BuildContext context,
    required WidgetRef ref,
    required ProviderBase<ApiResponseBase> apiResponseProvider,
    required Function callBack,
    List<Object>? positionalParams,
    Map<Symbol, dynamic>? namedParams,
  }) {
    ApiResponseBase responseState = ref.read(apiResponseProvider);
    if (responseState is ApiResponseError ||
        responseState is ApiResponse && !responseState.isSuccess) {
      showOnlyCloseDialog(
        context: context,
        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
      );
    } else {
      if (positionalParams != null || namedParams != null) {
        Function.apply(callBack, positionalParams);
      } else {
        callBack();
      }
    }
  }
}
