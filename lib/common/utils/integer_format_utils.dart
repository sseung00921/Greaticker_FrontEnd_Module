import 'package:intl/intl.dart';

class IntegerFormatUtils{
  static String convertToOrdinal(int number) {
    if (number < 0) return number.toString(); // 음수는 처리하지 않음

    // 숫자의 마지막 두 자리가 11, 12, 13이면 무조건 'th'로 끝남
    if ((number % 100) >= 11 && (number % 100) <= 13) {
      return "${number}th";
    }

    // 나머지 경우에 따라 'st', 'nd', 'rd', 'th' 접미사 붙이기
    switch (number % 10) {
      case 1:
        return "${number}st";
      case 2:
        return "${number}nd";
      case 3:
        return "${number}rd";
      default:
        return "${number}th";
    }
  }
}