import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/interval_event.dart';

void main() {
  late IntervalEvent tested;

  setUp(() {
    tested = IntervalEvent();
  });

  test('Init', () async {
    // THEN
    expect(
      tested,
      IntervalEvent(
        startDateTime: null,
        endDateTime: null,
      ),
    );
  });

  test('Start event', () async {
    // WHEN
    tested.startEvent();

    // THEN
    expect(tested.startDateTime, isNot(null));
  });

  test('End event', () async {
    // WHEN
    tested.finishEvent();

    // THEN
    expect(tested.endDateTime, isNot(null));
  });
}
