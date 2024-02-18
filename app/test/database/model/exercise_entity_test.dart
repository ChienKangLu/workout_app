import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/schema.dart';

void main() {
  const exerciseId = 1;
  const name = "squat";

  late ExerciseEntity tested;

  void verifyEntity({
    int? expectedExerciseId,
    String? expectedName,
  }) {
    expect(tested.exerciseId, expectedExerciseId);
    expect(tested.name, expectedName);
  }

  void verifyMap(
    Map actualMap, {
    int? expectedExerciseId,
    String? expectedName,
  }) {
    expect(actualMap[ExerciseTable.columnExerciseId], expectedExerciseId);
    expect(actualMap[ExerciseTable.columnExerciseName], expectedName);
  }

  test('Entity for creation', () {
    // GIVEN
    tested = ExerciseEntity.create(name: name);

    // WHEN
    final map = tested.toMap();

    // THEN
    verifyEntity(
      expectedExerciseId: ignored,
      expectedName: name,
    );
    verifyMap(
      map,
      expectedExerciseId: null,
      expectedName: name,
    );
  });

  test('Entity for update', () {
    // GIVEN
    tested = ExerciseEntity.update(exerciseId: exerciseId, name: name);

    // WHEN
    final map = tested.toMap();

    // THEN
    verifyEntity(
      expectedExerciseId: exerciseId,
      expectedName: name,
    );
    verifyMap(
      map,
      expectedExerciseId: exerciseId,
      expectedName: name,
    );
  });

  test('Entity from map', () {
    // GIVEN
    final map = {
      ExerciseTable.columnExerciseId: exerciseId,
      ExerciseTable.columnExerciseName: name,
    };

    // WHEN
    tested = ExerciseEntity.fromMap(map);

    // THEN
    verifyMap(
      map,
      expectedExerciseId: exerciseId,
      expectedName: name,
    );
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = ExerciseEntity(exerciseId: exerciseId, name: name);
    final other = ExerciseEntity(exerciseId: exerciseId, name: name);

    // WHEN
    final equalityResult = tested == other;

    // THEN
    expect(equalityResult, true);
    expect(tested.hashCode, other.hashCode);
  });

  test('String representation of entity', () {
    // GIVEN
    final map = {
      ExerciseTable.columnExerciseId: exerciseId,
      ExerciseTable.columnExerciseName: name,
    };
    tested = ExerciseEntity.fromMap(map);

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, map.toString());
  });
}
