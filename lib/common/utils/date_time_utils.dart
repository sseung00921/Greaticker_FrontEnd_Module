import 'package:intl/intl.dart';

class DateTimeUtils{
  static DateTime stringToDateTime(String value){
    return DateTime.parse(value);
  }

  static String dateTimeToString(DateTime value, String format){
    final DateFormat formatter = DateFormat(format);
    return formatter.format(value);
  }

}