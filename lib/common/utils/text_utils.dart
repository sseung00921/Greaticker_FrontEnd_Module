import 'package:flutter/material.dart';

class TextUtils {
  static bool _isTextExceedingMaxWidth({required String text, required double fontSize, required String fontFamily, required double maxWidth}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize, fontFamily: fontFamily),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )
      ..layout();

    return textPainter.width > maxWidth;
  }
}