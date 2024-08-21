import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/common.dart';

Future<void> showSelectOneBetweenTwoModal({
  required BuildContext context,
  required String option1,
  required String option2,
  required Future<void> Function() onNext,
  VoidCallback? afterModal,
}) {
  int selectedOption = 0; // 기본적으로 첫 번째 옵션이 선택된 상태

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<int>(
                  title: Text(
                    option1,
                    style: YeongdeokSeaTextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: 0,
                  groupValue: selectedOption,
                  onChanged: (int? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text(
                    option2,
                    style: YeongdeokSeaTextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (int? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await onNext(); // Yes action
                  if (afterModal != null) {
                    afterModal();
                  }
                },
                child: Text(
                  BUTTON_DICT[dotenv.get(LANGUAGE)]!['next']!,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
