import 'package:flutter/material.dart';
import 'package:greaticker/common/component/text_style.dart';

Future<void> showOneTextInputDialog({
  required BuildContext context,
  required String comment,
  required Future<void> Function(String value) onSubmitted,
  VoidCallback? afterModal,
}) {
  final TextEditingController _controller = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              comment,
              style: YeongdeokSeaTextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter your text here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await onSubmitted(_controller.text);
              if (afterModal != null) {
                afterModal();
              }// 입력된 텍스트를 전달
            },
            child: Text(
              'enter',
            ),
          ),
        ],
      );
    },
  );
}
