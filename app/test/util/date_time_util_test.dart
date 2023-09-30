import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/util/date_time_util.dart';

void main() {
  test('String of date and time', () {
    // GIVEN
    final dateTime = DateTime(2023, 9, 29, 5, 33, 20, 999, 0);

    // WHEN
    final result = DateTimeUtil.dateTimeString(dateTime);

    // THEN
    expect(result, "Sep 29, 2023 at 5:33 AM");
  });

  test('String of day', () {
    // GIVEN
    final dateTime = DateTime(2023, 9, 29, 5, 33, 20, 999, 0);

    // WHEN
    final result = DateTimeUtil.dayString(dateTime);

    // THEN
    expect(result, "Sep");
  });

  test('String of date', () {
    // GIVEN
    final dateTime = DateTime(2023, 9, 29, 5, 33, 20, 999, 0);

    // WHEN
    final result = DateTimeUtil.dateString(dateTime);

    // THEN
    expect(result, "29");
  });

  test('String of time', () {
    // GIVEN
    final dateTime = DateTime(2023, 9, 29, 5, 33, 20, 999, 0);

    // WHEN
    final result = DateTimeUtil.timeString(dateTime);

    // THEN
    expect(result, "05:33 AM");
  });

  test('String of duration including seconds', () {
    // GIVEN
    const duration = Duration(seconds: 50);

    // WHEN
    final result = DateTimeUtil.durationString(duration);

    // THEN
    expect(result, "00:00:50");
  });

  test('String of duration including minutes and seconds', () {
    // GIVEN
    const duration = Duration(minutes: 55, seconds: 50);

    // WHEN
    final result = DateTimeUtil.durationString(duration);

    // THEN
    expect(result, "00:55:50");
  });

  test('String of duration including hours, minutes and seconds', () {
    // GIVEN
    const duration = Duration(hours: 1, minutes: 55, seconds: 50);

    // WHEN
    final result = DateTimeUtil.durationString(duration);

    // THEN
    expect(result, "01:55:50");
  });

  test('String of month', () {
    // GIVEN
    final monthList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 0, -1];

    // WHEN
    final monthStringList = monthList.map((month) => month.toMonthString());

    // THEN
    expect(
      monthStringList,
      [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
        '',
        '',
        ''
      ],
    );
  });
}
