import 'package:flutter_test/flutter_test.dart';
import 'package:greaticker/common/utils/integer_format_utils.dart';

void main() {
  group('convertToOrdinal', () {
    test('returns correct ordinal for numbers ending in 1', () {
      expect(IntegerFormatUtils.convertToOrdinal(1), equals('1st'));
      expect(IntegerFormatUtils.convertToOrdinal(21), equals('21st'));
      expect(IntegerFormatUtils.convertToOrdinal(101), equals('101st'));
    });

    test('returns correct ordinal for numbers ending in 2', () {
      expect(IntegerFormatUtils.convertToOrdinal(2), equals('2nd'));
      expect(IntegerFormatUtils.convertToOrdinal(22), equals('22nd'));
      expect(IntegerFormatUtils.convertToOrdinal(102), equals('102nd'));
    });

    test('returns correct ordinal for numbers ending in 3', () {
      expect(IntegerFormatUtils.convertToOrdinal(3), equals('3rd'));
      expect(IntegerFormatUtils.convertToOrdinal(23), equals('23rd'));
      expect(IntegerFormatUtils.convertToOrdinal(103), equals('103rd'));
    });

    test('returns correct ordinal for numbers ending in 4 through 9 or 0', () {
      expect(IntegerFormatUtils.convertToOrdinal(4), equals('4th'));
      expect(IntegerFormatUtils.convertToOrdinal(11), equals('11th'));
      expect(IntegerFormatUtils.convertToOrdinal(12), equals('12th'));
      expect(IntegerFormatUtils.convertToOrdinal(13), equals('13th'));
      expect(IntegerFormatUtils.convertToOrdinal(14), equals('14th'));
      expect(IntegerFormatUtils.convertToOrdinal(100), equals('100th'));
    });

    test('returns correct ordinal for numbers 11, 12, 13', () {
      expect(IntegerFormatUtils.convertToOrdinal(11), equals('11th'));
      expect(IntegerFormatUtils.convertToOrdinal(12), equals('12th'));
      expect(IntegerFormatUtils.convertToOrdinal(13), equals('13th'));
      expect(IntegerFormatUtils.convertToOrdinal(111), equals('111th'));
    });

    test('returns correct ordinal for negative numbers', () {
      expect(IntegerFormatUtils.convertToOrdinal(-1), equals('-1'));
      expect(IntegerFormatUtils.convertToOrdinal(-22), equals('-22'));
    });
  });
}