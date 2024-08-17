import 'package:flutter/material.dart';
import 'package:greaticker/common/component/text_style.dart';

Future<void> showOnlyCloseDialog({
  required BuildContext context,
  required String comment,
}) {
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
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'close',
            ),
          ),
        ],
      );
    },
  );
}
