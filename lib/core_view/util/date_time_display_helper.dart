import 'package:intl/intl.dart';

class DateTimeDisplayHelper {
  static final DateFormat formatter = DateFormat("MMM dd, y 'at' h:mm a");

  static String dateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }

    return formatter.format(dateTime);
  }
}