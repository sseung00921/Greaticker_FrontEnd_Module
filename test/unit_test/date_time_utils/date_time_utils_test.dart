import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/utils/date_time_utils.dart';

void main() {
  group('DateUtils', () {
    test(
        'stringToDateTime should correctly parse a valid ISO 8601 date string', () {
      String dateString = '2023-08-13T12:34:56.789Z';

      DateTime result = DateTimeUtils.stringToDateTime(dateString);

      expect(result.year, 2023);
      expect(result.month, 8);
      expect(result.day, 13);
      expect(result.hour, 12);
      expect(result.minute, 34);
      expect(result.second, 56);
      expect(result.millisecond, 789);
    });

    test(
        'dateTimeToString should correctly format a DateTime object to string', () {
      DateTime date = DateTime(
          2023,
          8,
          13,
          12,
          34,
          56,
          789);
      String format = 'yyyy-MM-dd HH:mm:ss.SSS';

      String result = DateTimeUtils.dateTimeToString(date, format);

      expect(result, '2023-08-13 12:34:56.789');
    });

    test('dateTimeToString should correctly handle different formats', () {
      DateTime date = DateTime(
          2023,
          8,
          13,
          12,
          34,
          56,
          789);
      String format = 'MMMM d, yyyy';

      String result = DateTimeUtils.dateTimeToString(date, format);

      expect(result, 'August 13, 2023');
    });

    test(
        'stringToDateTime should throw FormatException for invalid date string', () {
      String invalidDateString = 'invalid-date-string';

      expect(() => DateTimeUtils.stringToDateTime(invalidDateString),
          throwsFormatException);
    });
  });
}