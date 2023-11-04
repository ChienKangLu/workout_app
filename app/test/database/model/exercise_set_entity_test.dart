import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';
import 'package:workout_app/database/schema.dart';

void main() {
  const workoutId = 1;
  const exerciseId = 2;
  const setNum = 3;
  const baseWeight = 20.0;
  const sideWeight = 15.0;
  const repetition = 5;
  const endDateTime = 10;

  late ExerciseSetEntity tested;

  void verifyEntity({
    int? expectedWorkoutId,
    int? expectedExerciseId,
    int? expectedSetNum,
    double? expectedBaseWeight,
    double? expectedSideWeight,
    int? expectedRepetition,
    int? expectedEndDateTime,
  }) {
    expect(tested.workoutId, expectedWorkoutId);
    expect(tested.exerciseId, expectedExerciseId);
    expect(tested.setNum, expectedSetNum);
    expect(tested.baseWeight, expectedBaseWeight);
    expect(tested.sideWeight, expectedSideWeight);
    expect(tested.repetition, expectedRepetition);
    expect(tested.endDateTime, expectedEndDateTime);
  }

  void verifyMap(
    Map actualMap, {
    int? expectedWorkoutId,
    int? expectedExerciseId,
    int? expectedSetNum,
    double? expectedBaseWeight,
    double? expectedSideWeight,
    int? expectedRepetition,
    int? expectedEndDateTime,
  }) {
    expect(actualMap[ExerciseSetTable.columnWorkoutId], expectedWorkoutId);
    expect(actualMap[ExerciseSetTable.columnExerciseId], expectedExerciseId);
    expect(actualMap[ExerciseSetTable.columnSetNum], expectedSetNum);
    expect(actualMap[ExerciseSetTable.columnBaseWeight], expectedBaseWeight);
    expect(actualMap[ExerciseSetTable.columnSideWeight], expectedSideWeight);
    expect(actualMap[ExerciseSetTable.columnRepetition], expectedRepetition);
    expect(
        actualMap[ExerciseSetTable.columnSetEndDateTime], expectedEndDateTime);
  }

  test('Entity for creation', () {
    // GIVEN
    tested = ExerciseSetEntity.create(
      workoutId: workoutId,
      exerciseId: exerciseId,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
      endDateTime: endDateTime,
    );

    // WHEN
    final map = tested.toMap();

    // THEN
    verifyEntity(
      expectedWorkoutId: workoutId,
      expectedExerciseId: exerciseId,
      expectedSetNum: ignored,
      expectedBaseWeight: baseWeight,
      expectedSideWeight: sideWeight,
      expectedRepetition: repetition,
      expectedEndDateTime: endDateTime,
    );
    verifyMap(
      map,
      expectedWorkoutId: workoutId,
      expectedExerciseId: exerciseId,
      expectedSetNum: null,
      expectedBaseWeight: baseWeight,
      expectedSideWeight: sideWeight,
      expectedRepetition: repetition,
      expectedEndDateTime: endDateTime,
    );
  });

  test('Entity for update', () {
    // GIVEN
    tested = ExerciseSetEntity.update(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
    );

    // WHEN
    final map = tested.toMap();

    // THEN
    verifyEntity(
      expectedWorkoutId: workoutId,
      expectedExerciseId: exerciseId,
      expectedSetNum: setNum,
      expectedBaseWeight: baseWeight,
      expectedSideWeight: sideWeight,
      expectedRepetition: repetition,
      expectedEndDateTime: ignored,
    );
    verifyMap(
      map,
      expectedWorkoutId: workoutId,
      expectedExerciseId: exerciseId,
      expectedSetNum: setNum,
      expectedBaseWeight: baseWeight,
      expectedSideWeight: sideWeight,
      expectedRepetition: repetition,
      expectedEndDateTime: null,
    );
  });

  test('Entity from map', () {
    // GIVEN
    final map = {
      ExerciseSetTable.columnWorkoutId: workoutId,
      ExerciseSetTable.columnExerciseId: exerciseId,
      ExerciseSetTable.columnSetNum: setNum,
      ExerciseSetTable.columnBaseWeight: baseWeight,
      ExerciseSetTable.columnSideWeight: sideWeight,
      ExerciseSetTable.columnRepetition: repetition,
      ExerciseSetTable.columnSetEndDateTime: endDateTime,
    };

    // WHEN
    tested = ExerciseSetEntity.fromMap(map);

    // THEN
    verifyMap(
      map,
      expectedWorkoutId: workoutId,
      expectedExerciseId: exerciseId,
      expectedSetNum: setNum,
      expectedBaseWeight: baseWeight,
      expectedSideWeight: sideWeight,
      expectedRepetition: repetition,
      expectedEndDateTime: endDateTime,
    );
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = ExerciseSetEntity(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
      endDateTime: endDateTime,
    );
    final other = ExerciseSetEntity(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
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
      ExerciseSetTable.columnWorkoutId: workoutId,
      ExerciseSetTable.columnExerciseId: exerciseId,
      ExerciseSetTable.columnSetNum: setNum,
      ExerciseSetTable.columnBaseWeight: baseWeight,
      ExerciseSetTable.columnSideWeight: sideWeight,
      ExerciseSetTable.columnRepetition: repetition,
      ExerciseSetTable.columnSetEndDateTime: endDateTime,
    };
    tested = ExerciseSetEntity.fromMap(map);

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, map.toString());
  });
}
