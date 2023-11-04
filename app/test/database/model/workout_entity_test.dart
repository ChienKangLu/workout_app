import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/workout_entity.dart';
import 'package:workout_app/database/schema.dart';

void main() {
  const workoutId = 1;
  const createDateTime = 2;
  const startDateTime = 3;
  const endDateTime = 4;

  late WorkoutEntity tested;

  void verifyEntity({
    int? expectedWorkoutId,
    int? expectedCreateDateTime,
    int? expectedStartDateTime,
    int? expectedEndDateTime,
  }) {
    expect(tested.workoutId, expectedWorkoutId);
    expect(tested.createDateTime, expectedCreateDateTime);
    expect(tested.startDateTime, expectedStartDateTime);
    expect(tested.endDateTime, expectedEndDateTime);
  }

  void verifyMap(
    Map actualMap, {
    int? expectedWorkoutId,
    int? expectedCreateDateTime,
    int? expectedStartDateTime,
    int? expectedEndDateTime,
  }) {
    expect(actualMap[WorkoutTable.columnWorkoutId], expectedWorkoutId);
    expect(
      actualMap[WorkoutTable.columnWorkoutCreateDateTime],
      expectedCreateDateTime,
    );
    expect(
      actualMap[WorkoutTable.columnWorkoutStartDateTime],
      expectedStartDateTime,
    );
    expect(
      actualMap[WorkoutTable.columnWorkoutEndDateTime],
      expectedEndDateTime,
    );
  }

  test('Entity for creation', () {
    // GIVEN
    tested = WorkoutEntity.create(
      createDateTime: createDateTime,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );

    // WHEN
    final map = tested.toMap();

    // THEN
    verifyEntity(
      expectedWorkoutId: ignored,
      expectedCreateDateTime: createDateTime,
      expectedStartDateTime: startDateTime,
      expectedEndDateTime: endDateTime,
    );
    verifyMap(
      map,
      expectedWorkoutId: null,
      expectedCreateDateTime: createDateTime,
      expectedStartDateTime: startDateTime,
      expectedEndDateTime: endDateTime,
    );
  });

  test('Entity from map', () {
    // GIVEN
    final map = {
      WorkoutTable.columnWorkoutId: workoutId,
      WorkoutTable.columnWorkoutCreateDateTime: createDateTime,
      WorkoutTable.columnWorkoutStartDateTime: startDateTime,
      WorkoutTable.columnWorkoutEndDateTime: endDateTime,
    };

    // WHEN
    tested = WorkoutEntity.fromMap(map);

    // THEN
    verifyMap(
      map,
      expectedWorkoutId: workoutId,
      expectedCreateDateTime: createDateTime,
      expectedStartDateTime: startDateTime,
      expectedEndDateTime: endDateTime,
    );
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = WorkoutEntity(
      workoutId: workoutId,
      createDateTime: createDateTime,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );
    final other = WorkoutEntity(
      workoutId: workoutId,
      createDateTime: createDateTime,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );

    // WHEN
    final equalityResult = tested == other;

    // THEN
    expect(equalityResult, true);
    expect(tested.hashCode, other.hashCode);
  });

  test('String representation of entity', () {
    // GIVEN
    final map = {
      WorkoutTable.columnWorkoutId: workoutId,
      WorkoutTable.columnWorkoutCreateDateTime: createDateTime,
      WorkoutTable.columnWorkoutStartDateTime: startDateTime,
      WorkoutTable.columnWorkoutEndDateTime: endDateTime,
    };
    tested = WorkoutEntity.fromMap(map);

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, map.toString());
  });
}
