import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/embedded_object/exercise_with_sets_entity.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';

void main() {
  const exerciseId = 1;
  const name = "squat";
  const workoutId = 2;
  const setNum = 3;
  const baseWeight = 20.0;
  const sideWeight = 15.0;
  const repetition = 5;
  const endDateTime = 10;

  late ExerciseWithSetsEntity tested;

  test('Entity for creation', () {
    // GIVEN
    final exerciseEntity = ExerciseEntity(exerciseId: exerciseId, name: name);
    final exerciseSetEntities = [
      ExerciseSetEntity(
        workoutId: workoutId,
        exerciseId: exerciseId,
        setNum: setNum,
        baseWeight: baseWeight,
        sideWeight: sideWeight,
        repetition: repetition,
        endDateTime: endDateTime,
      ),
    ];

    // WHEN
    tested = ExerciseWithSetsEntity(
      exerciseEntity: exerciseEntity,
      exerciseSetEntities: exerciseSetEntities,
    );

    // THEN
    expect(tested.exerciseEntity, exerciseEntity);
    expect(tested.exerciseSetEntities, exerciseSetEntities);
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = ExerciseWithSetsEntity(
      exerciseEntity: ExerciseEntity(exerciseId: exerciseId, name: name),
      exerciseSetEntities: [
        ExerciseSetEntity(
          workoutId: workoutId,
          exerciseId: exerciseId,
          setNum: setNum,
          baseWeight: baseWeight,
          sideWeight: sideWeight,
          repetition: repetition,
          endDateTime: endDateTime,
        ),
      ],
    );
    final other = ExerciseWithSetsEntity(
      exerciseEntity: ExerciseEntity(exerciseId: exerciseId, name: name),
      exerciseSetEntities: [
        ExerciseSetEntity(
          workoutId: workoutId,
          exerciseId: exerciseId,
          setNum: setNum,
          baseWeight: baseWeight,
          sideWeight: sideWeight,
          repetition: repetition,
          endDateTime: endDateTime,
        ),
      ],
    );

    // WHEN
    final equalityResult = tested == other;

    // THEN
    expect(equalityResult, true);
    expect(tested.hashCode, other.hashCode);
  });

  test('String representation of entity', () {
    // GIVEN
    tested = ExerciseWithSetsEntity(
      exerciseEntity: ExerciseEntity(exerciseId: exerciseId, name: name),
      exerciseSetEntities: [
        ExerciseSetEntity(
          workoutId: workoutId,
          exerciseId: exerciseId,
          setNum: setNum,
          baseWeight: baseWeight,
          sideWeight: sideWeight,
          repetition: repetition,
          endDateTime: endDateTime,
        ),
      ],
    );

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, tested.toMap().toString());
  });
}
