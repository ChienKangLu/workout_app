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

extension IntExtension on int {
  String toMonthString() {
    final String text;
    switch (this) {
      case 1:
        text = 'Jan';
        break;
      case 2:
        text = 'Feb';
        break;
      case 3:
        text = 'Mar';
        break;
      case 4:
        text = 'Apr';
        break;
      case 5:
        text = 'May';
        break;
      case 6:
        text = 'Jun';
        break;
      case 7:
        text = 'Jul';
        break;
      case 8:
        text = 'Aug';
        break;
      case 9:
        text = 'Sep';
        break;
      case 10:
        text = 'Oct';
        break;
      case 11:
        text = 'Nov';
        break;
      case 12:
        text = 'Dec';
        break;
      default:
        text = '';
    }
    return text;
  }
}