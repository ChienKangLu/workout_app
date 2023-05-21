import 'package:intl/intl.dart';

class DateTimeDisplayHelper {
  static final DateFormat dateTimeFormatter = DateFormat("MMM dd, y 'at' h:mm a");
  static final DateFormat dayFormatter = DateFormat("MMM");
  static final DateFormat dateFormatter = DateFormat("dd");

  static String dateTime(DateTime? dateTime) => _format(dateTime, dateTimeFormatter);

  static String day(DateTime? dateTime) => _format(dateTime, dayFormatter);

  static String date(DateTime? dateTime) => _format(dateTime, dateFormatter);

  static String _format(DateTime? dateTime, DateFormat format) {
    if (dateTime == null) {
      return "";
    }

    return format.format(dateTime);
  }
}