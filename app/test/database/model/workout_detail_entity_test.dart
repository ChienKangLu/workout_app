import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/workout_detail_entity.dart';
import 'package:workout_app/database/schema.dart';

void main() {
  const workoutId = 1;
  const exerciseId = 2;
  const createDateTime = 3;

  late WorkoutDetailEntity tested;

  void verifyMap(
    Map actualMap, {
    int? expectedWorkoutId,
    int? expectedExerciseId,
    int? expectedCreateDateTime,
  }) {
    expect(actualMap[WorkoutDetailTable.columnWorkoutId], expectedWorkoutId);
    expect(actualMap[WorkoutDetailTable.columnExerciseId], expectedExerciseId);
    expect(
      actualMap[WorkoutDetailTable.columnExerciseCreateDateTime],
      expectedCreateDateTime,
    );
  }

  test('Entity from map', () {
    // GIVEN
    final map = {
      WorkoutDetailTable.columnWorkoutId: workoutId,
      WorkoutDetailTable.columnExerciseId: exerciseId,
      WorkoutDetailTable.columnExerciseCreateDateTime: createDateTime,
    };

    // WHEN
    tested = WorkoutDetailEntity.fromMap(map);

    // THEN
    verifyMap(
      map,
      expectedWorkoutId: workoutId,
      expectedExerciseId: exerciseId,
      expectedCreateDateTime: createDateTime,
    );
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = WorkoutDetailEntity(
      workoutId: workoutId,
      exerciseId: exerciseId,
      createDateTime: createDateTime,
    );
    final other = WorkoutDetailEntity(
      workoutId: workoutId,
      exerciseId: exerciseId,
      createDateTime: createDateTime,
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
      WorkoutDetailTable.columnWorkoutId: workoutId,
      WorkoutDetailTable.columnExerciseId: exerciseId,
      WorkoutDetailTable.columnExerciseCreateDateTime: createDateTime,
    };
    tested = WorkoutDetailEntity.fromMap(map);

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, map.toString());
  });
}
