import 'package:intl/intl.dart';

class DateTimeUtil {
  static final _dateTimeFormatter = DateFormat("MMM dd, y 'at' h:mm a");
  static final _dayFormatter = DateFormat("MMM");
  static final _dateFormatter = DateFormat("dd");
  static final _timeFormatter = DateFormat("hh:mm a");

  static String dateTimeString(DateTime? dateTime) =>
      _format(dateTime, _dateTimeFormatter);

  static String dayString(DateTime? dateTime) =>
      _format(dateTime, _dayFormatter);

  static String dateString(DateTime? dateTime) =>
      _format(dateTime, _dateFormatter);

  static String timeString(DateTime? dateTime) =>
      _format(dateTime, _timeFormatter);

  static String durationString(Duration duration) {
    const padding = "0";
    final hours = duration.inHours.remainder(24).toString().padLeft(2, padding);
    final minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, padding);
    final seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, padding);
    return "$hours:$minutes:$seconds";
  }

  static String _format(DateTime? dateTime, DateFormat format) {
    if (dateTime == null) {
      return "";
    }

    return format.format(dateTime);
  }
}

extension IntExtension on int {
  String toMonthString() {
    switch (this) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
