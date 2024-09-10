import 'package:flutter/material.dart';
import 'package:greaticker/common/constants/fonts.dart';

TextStyle YeongdeokSeaTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
}) {
  return TextStyle(
    color: Colors.black,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: YEONGDEOK_SEA,
  );
}