import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/throttle_manager/throtlle_time_constant.dart';

final throttleManagerProvider = Provider<ThrottleManager>((ref) {
  final throttleManager = ThrottleManager(throttleDuration: ThrottleTimeConstant);

  return throttleManager;
});

class ThrottleManager {
  final Duration throttleDuration;
  Map<String, DateTime?> _lastExecutionTime = {};

  ThrottleManager({required this.throttleDuration});

  Future<T?> executeWithModal<T>(String methodName, BuildContext context, Future<T> Function() action) async {
    final now = DateTime.now();
    final lastExecution = _lastExecutionTime[methodName];

    if (lastExecution == null || now.difference(lastExecution) > throttleDuration) {
      _lastExecutionTime[methodName] = now;
      return await action();
    } else {
      final remainingTime = throttleDuration - now.difference(lastExecution);

      _showThrottleModal(context, remainingTime);

      print("Request $methodName throttled. Remaining time: ${remainingTime.inSeconds} seconds");
      return null; // 요청이 throttle된 경우 null을 반환하거나, 적절한 대체 행동을 정의
    }
  }

  Future<T?> execute<T>(String methodName, Future<T> Function() action) async {
    final now = DateTime.now();
    final lastExecution = _lastExecutionTime[methodName];

    if (lastExecution == null || now.difference(lastExecution) > throttleDuration) {
      _lastExecutionTime[methodName] = now;
      return await action();
    } else {
      return null; // 요청이 throttle된 경우 null을 반환하거나, 적절한 대체 행동을 정의
    }
  }

  void _showThrottleModal(BuildContext context, Duration remainingTime) {
    showOnlyCloseDialog(context: context, comment: throttleModalContentMaker(remainingTime));
  }

  String throttleModalContentMaker(Duration remainingTime) {
    if (dotenv.get(LANGUAGE) == "KO") {
      return "${remainingTime.inSeconds}초 후에 다시 시도해 주세요";
    } else if (dotenv.get(LANGUAGE) == "EN") {
      return "You can try again in ${remainingTime.inSeconds} seconds.";
    } else {
      return "";
    }
  }
}
