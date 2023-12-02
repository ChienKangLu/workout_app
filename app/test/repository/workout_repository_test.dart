import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/database/dao/composed_workout_dao.dart';
import 'package:workout_app/database/dao/dao_result.dart';
import 'package:workout_app/database/dao/exercise_set_dao.dart';
import 'package:workout_app/database/dao/workout_dao.dart';
import 'package:workout_app/database/dao/workout_detail_dao.dart';
import 'package:workout_app/database/model/embedded_object/exercise_with_sets_entity.dart';
import 'package:workout_app/database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';
import 'package:workout_app/database/model/workout_entity.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/unit.dart';
import 'package:workout_app/model/workout.dart';
import 'package:workout_app/repository/conversion.dart';
import 'package:workout_app/repository/workout_repository.dart';

import '../util/mock_db.dart';
import 'repository_test_util.dart';

void main() {
  late MockDB mockDb;
  late WorkoutRepository tested;

  setUp(() {
    mockDb = MockDB()..setUp();

    tested = WorkoutRepository();
  });

  test('Create workout', () async {
    // GIVEN
    const rowId = 1;

    when(
      mockDb.workoutDao.add(
        any,
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(rowId),
    );

    // WHEN
    final result = await tested.createWorkout();

    // THEN
    final data = successData(result);
    expect(data, rowId);
  });

  test(
    'Remove workouts and failed due to error of removing exercise sets',
    () async {
      // GIVEN
      const workoutIds = [1, 2];
      final exception = Exception();

      when(
        mockDb.exerciseSetDao.delete(
          ExerciseSetEntityFilter(
            workoutIds: workoutIds,
          ),
        ),
      ).thenAnswer(
        (_) async => DaoError(exception),
      );

      // WHEN
      final result = await tested.deleteWorkouts(workoutIds);

      // THEN
      final data = errorException(result);
      expect(data, exception);
    },
  );

  test(
    'Remove workouts and failed due to error of removing workout detail',
    () async {
      // GIVEN
      const workoutIds = [1, 2];
      final exception = Exception();

      when(
        mockDb.exerciseSetDao.delete(
          ExerciseSetEntityFilter(
            workoutIds: workoutIds,
          ),
        ),
      ).thenAnswer(
        (_) async => DaoSuccess(true),
      );
      when(
        mockDb.workoutDetailDao.delete(
          WorkoutDetailEntityFilter(
            workoutIds: workoutIds,
          ),
        ),
      ).thenAnswer(
        (_) async => DaoError(exception),
      );

      // WHEN
      final result = await tested.deleteWorkouts(workoutIds);

      // THEN
      final data = errorException(result);
      expect(data, exception);
    },
  );

  test('Remove workouts', () async {
    // GIVEN
    const workoutIds = [1, 2];

    when(
      mockDb.exerciseSetDao.delete(
        ExerciseSetEntityFilter(
          workoutIds: workoutIds,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );
    when(
      mockDb.workoutDetailDao.delete(
        WorkoutDetailEntityFilter(
          workoutIds: workoutIds,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );
    when(
      mockDb.workoutDao.delete(
        WorkoutEntityFilter(
          ids: workoutIds,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result = await tested.deleteWorkouts(workoutIds);

    // THEN
    final data = successData(result);
    expect(data, true);
  });

  test('Update workout', () async {
    // GIVEN
    final workout = Workout(workoutId: 1, createDateTime: DateTime(1970));

    when(
      mockDb.workoutDao.update(workout.asWorkoutEntity()),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result = await tested.updateWorkout(workout);

    // THEN
    final data = successData(result);
    expect(data, true);
  });

  test('Get workouts', () async {
    // GIVEN
    const workoutId = 1;
    const workoutIds = [workoutId];

    final squat = ExerciseEntity(exerciseId: 1, name: "Squat");
    when(
      mockDb.composedWorkoutDao.findByFilter(
        ComposedWorkoutFilter(
          workoutIds: workoutIds,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(
        [
          WorkoutWithExercisesAndSetsEntity(
            workoutEntity: WorkoutEntity(
              workoutId: workoutId,
              createDateTime: 1,
              startDateTime: 3,
              endDateTime: 5,
            ),
            exerciseWithSetsEntityMap: {
              squat: ExerciseWithSetsEntity(
                exerciseEntity: squat,
                exerciseSetEntities: [
                  ExerciseSetEntity(
                    workoutId: workoutId,
                    exerciseId: squat.exerciseId,
                    setNum: 1,
                    baseWeight: 20,
                    sideWeight: 50,
                    repetition: 5,
                    endDateTime: 4,
                  ),
                ],
              ),
            },
          )
        ],
      ),
    );

    // WHEN
    final result = await tested.getWorkouts(workoutIds: workoutIds);

    // THEN
    final data = successData(result);
    expect(
      data,
      [
        Workout(
          workoutId: workoutId,
          createDateTime: DateTime.fromMillisecondsSinceEpoch(1),
          exercises: [
            Exercise(
              exerciseId: squat.exerciseId,
              name: squat.name,
              sets: [
                ExerciseSet(
                  baseWeight: 20,
                  sideWeight: 50,
                  unit: WeightUnit.kilogram,
                  repetition: 5,
                )
              ],
            ),
          ],
          startDateTime: DateTime.fromMillisecondsSinceEpoch(3),
          endDateTime: DateTime.fromMillisecondsSinceEpoch(5),
        ),
      ],
    );
  });
}
