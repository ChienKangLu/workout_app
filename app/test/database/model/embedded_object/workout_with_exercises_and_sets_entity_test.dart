import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/embedded_object/exercise_with_sets_entity.dart';
import 'package:workout_app/database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';
import 'package:workout_app/database/model/workout_entity.dart';

void main() {
  const workoutId = 1;
  const workoutCreateDateTime = 2;
  const workoutStartDateTime = 3;
  const workoutEndDateTime = 10;

  const exerciseId = 1;
  const name = "squat";

  const setNum = 3;
  const baseWeight = 20.0;
  const sideWeight = 15.0;
  const repetition = 5;
  const endDateTime = 6;

  late WorkoutWithExercisesAndSetsEntity tested;

  test('Entity for creation', () {
    // GIVEN
    final workoutEntity = WorkoutEntity(
      workoutId: workoutId,
      createDateTime: workoutCreateDateTime,
      startDateTime: workoutStartDateTime,
      endDateTime: workoutEndDateTime,
    );

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

    final exerciseWithSetsEntityMap = {
      exerciseEntity: ExerciseWithSetsEntity(
        exerciseEntity: exerciseEntity,
        exerciseSetEntities: exerciseSetEntities,
      ),
    };

    // WHEN
    tested = WorkoutWithExercisesAndSetsEntity(
      workoutEntity: workoutEntity,
      exerciseWithSetsEntityMap: exerciseWithSetsEntityMap,
    );

    // THEN
    expect(tested.workoutEntity, workoutEntity);
    expect(tested.exerciseWithSetsEntityMap, exerciseWithSetsEntityMap);
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = WorkoutWithExercisesAndSetsEntity(
      workoutEntity: WorkoutEntity(
        workoutId: workoutId,
        createDateTime: workoutCreateDateTime,
        startDateTime: workoutStartDateTime,
        endDateTime: workoutEndDateTime,
      ),
      exerciseWithSetsEntityMap: {
        ExerciseEntity(exerciseId: exerciseId, name: name):
            ExerciseWithSetsEntity(
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
        ),
      },
    );
    final other = WorkoutWithExercisesAndSetsEntity(
      workoutEntity: WorkoutEntity(
        workoutId: workoutId,
        createDateTime: workoutCreateDateTime,
        startDateTime: workoutStartDateTime,
        endDateTime: workoutEndDateTime,
      ),
      exerciseWithSetsEntityMap: {
        ExerciseEntity(exerciseId: exerciseId, name: name):
            ExerciseWithSetsEntity(
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
        ),
      },
    );

    // WHEN
    final equalityResult = tested == other;

    // THEN
    expect(equalityResult, true);
    expect(tested.hashCode, other.hashCode);
  });

  test('String representation of entity', () {
    // GIVEN
    tested = WorkoutWithExercisesAndSetsEntity(
      workoutEntity: WorkoutEntity(
        workoutId: workoutId,
        createDateTime: workoutCreateDateTime,
        startDateTime: workoutStartDateTime,
        endDateTime: workoutEndDateTime,
      ),
      exerciseWithSetsEntityMap: {
        ExerciseEntity(exerciseId: exerciseId, name: name):
            ExerciseWithSetsEntity(
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
        ),
      },
    );

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, tested.toMap().toString());
  });
}
