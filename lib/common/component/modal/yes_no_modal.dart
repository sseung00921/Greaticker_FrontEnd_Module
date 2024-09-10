import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/common.dart';

Future<void> showYesNoDialog(
    {required BuildContext context,
     required String comment,
     required Future<void> Function() onYes,
     VoidCallback? afterModal,}
    ) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        content: Text(
          comment,
          style: YeongdeokSeaTextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              BUTTON_DICT[dotenv.get(LANGUAGE)]!['no']!,
              style: YeongdeokSeaTextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await onYes(); // Yes action
              if (afterModal != null) {
                afterModal();
              }
            },
            child: Text(
              BUTTON_DICT[dotenv.get(LANGUAGE)]!['yes']!,
              style: YeongdeokSeaTextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}
