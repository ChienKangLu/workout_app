import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/workout_status.dart';

void main() {
  test('Workout is created', () async {
    // GIVEN
    const startDateTime = null;
    const endDateTime = null;

    // WHEN
    final status = WorkoutStatus.fromDateTime(startDateTime, endDateTime);

    // THEN
    expect(status, WorkoutStatus.created);
  });

  test('Workout is in progress', () async {
    // GIVEN
    final startDateTime = DateTime(1970);
    const DateTime? endDateTime = null;

    // WHEN
    final status = WorkoutStatus.fromDateTime(startDateTime, endDateTime);

    // THEN
    expect(status, WorkoutStatus.inProgress);
  });

  test('Workout is finished', () async {
    // GIVEN
    final startDateTime = DateTime(1970);
    final endDateTime = DateTime(1970);

    // WHEN
    final status = WorkoutStatus.fromDateTime(startDateTime, endDateTime);

    // THEN
    expect(status, WorkoutStatus.finished);
  });

  test('Workout status is unknown', () async {
    // GIVEN
    const startDateTime = null;
    final endDateTime = DateTime(1970);

    // WHEN
    final status = WorkoutStatus.fromDateTime(startDateTime, endDateTime);

    // THEN
    expect(status, WorkoutStatus.unknown);
  });
}
