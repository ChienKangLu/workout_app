import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/database/dao/dao_result.dart';
import 'package:workout_app/database/dao/exercise_dao.dart';
import 'package:workout_app/database/dao/exercise_set_dao.dart';
import 'package:workout_app/database/dao/workout_detail_dao.dart';
import 'package:workout_app/database/model/embedded_object/exercise_statistic_entity.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';
import 'package:workout_app/database/model/monthly_max_weight_entity.dart';
import 'package:workout_app/database/model/workout_detail_entity.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/exercise_statistic.dart';
import 'package:workout_app/repository/exercise_repository.dart';

import '../util/mock_db.dart';
import 'repository_test_util.dart';

void main() {
  late MockDB mockDb;
  late ExerciseRepository tested;

  setUp(() {
    mockDb = MockDB()..setUp();

    tested = ExerciseRepository();
  });

  test('Get exercise by id', () async {
    // GIVEN
    const exerciseId = 1;

    when(
      mockDb.exerciseDao.findByFilter(
        ExerciseEntityFilter(id: exerciseId),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(
        [
          ExerciseEntity(exerciseId: 1, name: "Squat"),
        ],
      ),
    );

    // WHEN
    final result = await tested.getExercise(exerciseId);

    // THEN
    final data = successData(result);
    expect(
      data,
      Exercise(
        exerciseId: 1,
        name: "Squat",
      ),
    );
  });

  test('Get exercise by non-existed id', () async {
    // GIVEN
    const exerciseId = 1;

    when(
      mockDb.exerciseDao.findByFilter(
        ExerciseEntityFilter(id: 1),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess([]),
    );

    // WHEN
    final result = await tested.getExercise(exerciseId);

    // THEN
    final data = successData(result);
    expect(data, null);
  });

  test('Get exercises', () async {
    // GIVEN
    when(
      mockDb.exerciseDao.findByFilter(null),
    ).thenAnswer(
      (_) async => DaoSuccess(
        [
          ExerciseEntity(exerciseId: 1, name: "Squat"),
          ExerciseEntity(exerciseId: 2, name: "Bench press"),
        ],
      ),
    );

    // WHEN
    final result = await tested.getExercises();

    // THEN
    final data = successData(result);
    expect(
      data,
      [
        Exercise(
          exerciseId: 1,
          name: "Squat",
        ),
        Exercise(
          exerciseId: 2,
          name: "Bench press",
        ),
      ],
    );
  });

  test('Create exercise', () async {
    // GIVEN
    const rowId = 1;
    const name = "Squat";

    when(
      mockDb.exerciseDao.add(
        ExerciseEntity.create(
          name: name,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(rowId),
    );

    // WHEN
    final result = await tested.createExercise(name);

    // THEN
    final data = successData(result);
    expect(
      data,
      rowId,
    );
  });

  test('Add exercise', () async {
    // GIVEN
    const workoutId = 1;
    const exerciseId = 2;
    const rowId = 3;

    when(
      mockDb.workoutDetailDao.add(any),
    ).thenAnswer(
      (_) async => DaoSuccess(rowId),
    );

    // WHEN
    final result = await tested.addExercise(workoutId, exerciseId);

    // THEN
    final entity = verify(mockDb.workoutDetailDao.add(captureAny))
        .captured
        .single as WorkoutDetailEntity;
    expect(entity.workoutId, workoutId);
    expect(entity.exerciseId, exerciseId);
    expect(entity.createDateTime, greaterThan(0));

    final data = successData(result);
    expect(data, rowId);
  });

  test(
    'Remove exercise from workout and failed due to error of removing exercise sets',
    () async {
      // GIVEN
      const workoutId = 1;
      const exerciseId = 2;
      final exception = Exception();

      when(
        mockDb.exerciseSetDao.delete(
          ExerciseSetEntityFilter(
            workoutId: workoutId,
            exerciseId: exerciseId,
          ),
        ),
      ).thenAnswer(
        (_) async => DaoError(exception),
      );

      // WHEN
      final result =
          await tested.removeExerciseFromWorkout(workoutId, exerciseId);

      // THEN
      final data = errorException(result);
      expect(data, exception);
    },
  );

  test('Remove exercise from workout', () async {
    // GIVEN
    const workoutId = 1;
    const exerciseId = 2;

    when(
      mockDb.exerciseSetDao.delete(
        ExerciseSetEntityFilter(
          workoutId: workoutId,
          exerciseId: exerciseId,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );
    when(
      mockDb.workoutDetailDao.delete(
        WorkoutDetailEntityFilter(
          workoutId: workoutId,
          exerciseId: exerciseId,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result =
        await tested.removeExerciseFromWorkout(workoutId, exerciseId);

    // THEN
    final data = successData(result);
    expect(data, true);
  });

  test(
    'Remove exercises and failed due to error of removing exercise sets',
    () async {
      // GIVEN
      const exerciseIds = [1, 2];
      final exception = Exception();

      when(
        mockDb.exerciseSetDao.delete(
          ExerciseSetEntityFilter(
            exerciseIds: exerciseIds,
          ),
        ),
      ).thenAnswer(
        (_) async => DaoError(exception),
      );

      // WHEN
      final result = await tested.removeExercises(exerciseIds);

      // THEN
      final data = errorException(result);
      expect(data, exception);
    },
  );

  test(
    'Remove exercises and failed due to error of removing workout detail',
    () async {
      // GIVEN
      const exerciseIds = [1, 2];
      final exception = Exception();

      when(
        mockDb.exerciseSetDao.delete(
          ExerciseSetEntityFilter(
            exerciseIds: exerciseIds,
          ),
        ),
      ).thenAnswer(
        (_) async => DaoSuccess(true),
      );
      when(
        mockDb.workoutDetailDao.delete(
          WorkoutDetailEntityFilter(
            exerciseIds: exerciseIds,
          ),
        ),
      ).thenAnswer(
        (_) async => DaoError(exception),
      );

      // WHEN
      final result = await tested.removeExercises(exerciseIds);

      // THEN
      final data = errorException(result);
      expect(data, exception);
    },
  );
  test('Remove exercises', () async {
    // GIVEN
    const exerciseIds = [1, 2];

    when(
      mockDb.exerciseSetDao.delete(
        ExerciseSetEntityFilter(
          exerciseIds: exerciseIds,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );
    when(
      mockDb.workoutDetailDao.delete(
        WorkoutDetailEntityFilter(
          exerciseIds: exerciseIds,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );
    when(
      mockDb.exerciseDao.delete(
        ExerciseEntityFilter(ids: exerciseIds),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result = await tested.removeExercises(exerciseIds);

    // THEN
    final data = successData(result);
    expect(data, true);
  });

  test('update exercise', () async {
    // GIVEN
    const exerciseId = 1;
    const name = "Squat";

    when(
      mockDb.exerciseDao.update(
        ExerciseEntity.update(
          exerciseId: exerciseId,
          name: name,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result = await tested.updateExercise(
      exerciseId: exerciseId,
      name: name,
    );

    // THEN
    final data = successData(result);
    expect(data, true);
  });

  test('Add exercise set', () async {
    // GIVEN
    const workoutId = 1;
    const exerciseId = 2;
    const baseWeight = 3.0;
    const sideWeight = 4.0;
    const repetition = 5;
    const rowId = 6;

    when(
      mockDb.exerciseSetDao.add(
        any,
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(rowId),
    );

    // WHEN
    final result = await tested.addExerciseSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
    );

    // THEN
    final entity = verify(mockDb.exerciseSetDao.add(captureAny)).captured.single
        as ExerciseSetEntity;
    expect(entity.workoutId, workoutId);
    expect(entity.exerciseId, exerciseId);
    expect(entity.baseWeight, baseWeight);
    expect(entity.sideWeight, sideWeight);
    expect(entity.repetition, repetition);
    expect(entity.endDateTime, greaterThan(0));

    final data = successData(result);
    expect(data, rowId);
  });

  test('Update exercise set', () async {
    // GIVEN
    const workoutId = 1;
    const exerciseId = 2;
    const setNum = 3;
    const baseWeight = 4.0;
    const sideWeight = 5.0;
    const repetition = 6;

    when(
      mockDb.exerciseSetDao.update(
        ExerciseSetEntity.update(
          workoutId: workoutId,
          exerciseId: exerciseId,
          setNum: setNum,
          baseWeight: baseWeight,
          sideWeight: sideWeight,
          repetition: repetition,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result = await tested.updateExerciseSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
    );

    // THEN
    final data = successData(result);
    expect(data, true);
  });

  test('Remove exercise set', () async {
    // GIVEN
    const workoutId = 1;
    const exerciseId = 2;
    const setNum = 3;

    when(
      mockDb.exerciseSetDao.delete(
        ExerciseSetEntityFilter(
          workoutId: workoutId,
          exerciseId: exerciseId,
          setNum: setNum,
        ),
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result = await tested.removeExerciseSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
    );

    // THEN
    final data = successData(result);
    expect(data, true);
  });

  test('Get statistic', () async {
    // GIVEN
    const exerciseId = 2;
    const totalWeight = 3.0;
    const endDateTime = 4;
    const year = 5;
    const month = 6;

    when(
      mockDb.exerciseSetDao.getStatistic(
        exerciseId,
      ),
    ).thenAnswer(
      (_) async => DaoSuccess(
        ExerciseStatisticEntity(
          monthlyMaxWeightEntities: [
            MonthlyMaxWeightEntity(
              totalWeight: totalWeight,
              endDateTime: endDateTime,
              year: year,
              month: month,
            )
          ],
        ),
      ),
    );

    // WHEN
    final result = await tested.getStatistic(
      exerciseId,
    );

    // THEN
    final data = successData(result);
    expect(
      data,
      const ExerciseStatistic(
        monthlyMaxWeightList: [
          MonthlyMaxWeight(
            totalWeight: totalWeight,
            endDateTime: endDateTime,
            year: year,
            month: month,
          ),
        ],
      ),
    );
  });
}
