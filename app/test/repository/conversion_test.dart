import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/dao/dao_result.dart';
import 'package:workout_app/database/model/embedded_object/exercise_statistic_entity.dart';
import 'package:workout_app/database/model/embedded_object/exercise_with_sets_entity.dart';
import 'package:workout_app/database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';
import 'package:workout_app/database/model/monthly_max_weight_entity.dart';
import 'package:workout_app/database/model/water_goal_entity.dart';
import 'package:workout_app/database/model/water_log_entity.dart';
import 'package:workout_app/database/model/workout_entity.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/result.dart';
import 'package:workout_app/model/unit.dart';
import 'package:workout_app/model/water_goal.dart';
import 'package:workout_app/model/water_log.dart';
import 'package:workout_app/model/workout.dart';
import 'package:workout_app/repository/conversion.dart';

import '../database/model/dao/dao_test_util.dart';

void main() {
  test('Workout to WorkoutEntity', () {
    // GIVEN
    final createDateTime = DateTime(1970, 1, 1, 1);
    final startDateTime = DateTime(1970, 1, 1, 2);
    final endDateTime = DateTime(1970, 1, 1, 3);
    final workout = Workout(
      workoutId: 1,
      createDateTime: createDateTime,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );

    // WHEN
    final workoutEntity = workout.asWorkoutEntity();

    // THEN
    verifyWorkoutEntity(
      workoutEntity,
      expectedWorkoutId: 1,
      expectedCreateDateTime: createDateTime.millisecondsSinceEpoch,
      expectedStartDateTime: startDateTime.millisecondsSinceEpoch,
      expectedEndDateTime: endDateTime.millisecondsSinceEpoch,
    );
  });

  group('DaoResultConversion', () {
    T successData<T>(Result<T> result) {
      expect(result, isA<Success<T>>());
      return (result as Success<T>).data;
    }

    Exception errorException<T>(Result<T> result) {
      expect(result, isA<Error<T>>());
      return (result as Error<T>).exception;
    }

    test('DaoSuccess to Success', () {
      // GIVEN
      const data = true;
      final daoSuccess = DaoSuccess(data);

      // WHEN
      final result = daoSuccess.asResult();

      // THEN
      final resultData = successData(result);
      expect(resultData, data);
    });

    test('DaoSuccess to Success with convert', () {
      // GIVEN
      const data = 1;
      final daoSuccess = DaoSuccess(data);

      // WHEN
      const convertedData = true;
      final result = daoSuccess.asResult(
        convert: (data) => convertedData,
      );

      // THEN
      final resultData = successData(result);
      expect(resultData, convertedData);
    });

    test('DaoError to Error', () {
      // GIVEN
      final exception = Exception("error");
      final daoError = DaoError(exception);

      // WHEN
      final result = daoError.asResult();

      // THEN
      final resultException = errorException(result);
      expect(resultException, exception);
    });
  });

  test('ExerciseEntity to Exercise', () {
    // GIVEN
    const exerciseId = 1;
    const name = "Squat";
    final entity = ExerciseEntity(
      exerciseId: exerciseId,
      name: name,
    );

    // WHEN
    final exercise = entity.asExercise();

    // THEN
    expect(
      exercise,
      Exercise(
        exerciseId: exerciseId,
        name: name,
      ),
    );
  });

  test('ExerciseSetEntity to ExerciseSet', () {
    // GIVEN
    const workoutId = 1;
    const exerciseId = 2;
    const setNum = 3;
    const baseWeight = 20.0;
    const sideWeight = 10.0;
    const repetition = 5;
    const endDateTime = 1;
    final entity = ExerciseSetEntity(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
      endDateTime: endDateTime,
    );

    // WHEN
    final exercise = entity.asExerciseSet();

    // THEN
    expect(exercise.baseWeight, baseWeight);
    expect(exercise.sideWeight, sideWeight);
    expect(exercise.unit, WeightUnit.kilogram);
    expect(exercise.repetition, repetition);
  });

  test('ExerciseStatisticEntity to ExerciseStatistic', () {
    // GIVEN
    const totalWeight = 100.0;
    const endDateTime = 0;
    const year = 1970;
    const month = 1;
    final entity = ExerciseStatisticEntity(
      monthlyMaxWeightEntities: [
        MonthlyMaxWeightEntity(
          totalWeight: totalWeight,
          endDateTime: endDateTime,
          year: year,
          month: month,
        ),
      ],
    );

    // WHEN
    final exerciseStatistic = entity.asExerciseStatistic();

    // THEN
    final monthlyMaxWeightList = exerciseStatistic.monthlyMaxWeightList;
    final monthlyMaxWeight = monthlyMaxWeightList.first;
    expect(monthlyMaxWeight.totalWeight, totalWeight);
    expect(monthlyMaxWeight.endDateTime, endDateTime);
    expect(monthlyMaxWeight.year, year);
    expect(monthlyMaxWeight.month, month);
  });

  test('WaterGoalEntity to WaterGoal', () {
    // GIVEN
    const id = 1;
    const volume = 500.0;
    const dateTime = 100;
    final entity = WaterGoalEntity(
      id: id,
      volume: volume,
      dateTime: dateTime,
    );

    // WHEN
    final waterGoal = entity.asWaterGoal();

    // THEN
    expect(
      waterGoal,
      WaterGoal(
        id: id,
        volume: volume,
        dateTime: DateTime.fromMillisecondsSinceEpoch(dateTime),
      ),
    );
  });

  test('WaterLogEntity to WaterLog', () {
    // GIVEN
    const id = 1;
    const volume = 500.0;
    const dateTime = 100;
    final entity = WaterLogEntity(
      id: id,
      volume: volume,
      dateTime: dateTime,
    );

    // WHEN
    final waterLog = entity.asWaterLog();

    // THEN
    expect(
      waterLog,
      WaterLog(
        id: id,
        volume: volume,
        dateTime: DateTime.fromMillisecondsSinceEpoch(dateTime),
      ),
    );
  });

  test('WorkoutWithExercisesAndSetsEntity to Workout', () {
    // GIVEN
    final workoutEntity = WorkoutEntity(
      workoutId: 1,
      createDateTime: 2,
      startDateTime: 3,
      endDateTime: 4,
    );
    final exerciseEntity = ExerciseEntity(
      exerciseId: 1,
      name: "Squat",
    );
    final exerciseSetEntity = ExerciseSetEntity(
      workoutId: 1,
      exerciseId: 1,
      setNum: 5,
      baseWeight: 20,
      sideWeight: 15,
      repetition: 5,
      endDateTime: 1,
    );
    final workoutWithExercisesAndSetsEntity = WorkoutWithExercisesAndSetsEntity(
      workoutEntity: workoutEntity,
      exerciseWithSetsEntityMap: {
        exerciseEntity: ExerciseWithSetsEntity(
          exerciseEntity: exerciseEntity,
          exerciseSetEntities: [
            exerciseSetEntity,
          ],
        ),
      },
    );

    // WHEN
    final workout = workoutWithExercisesAndSetsEntity.asWorkout();

    // THEN
    expect(
      workout,
      Workout(
        workoutId: workoutEntity.workoutId,
        createDateTime:
            DateTime.fromMillisecondsSinceEpoch(workoutEntity.createDateTime),
      )
        ..setStartDateTime(DateTime.fromMillisecondsSinceEpoch(
            workoutEntity.startDateTime ?? 0))
        ..setEndDateTime(
            DateTime.fromMillisecondsSinceEpoch(workoutEntity.endDateTime ?? 0))
        ..addExercise(
          Exercise(
              exerciseId: exerciseEntity.exerciseId, name: exerciseEntity.name)
            ..addSet(
              ExerciseSet(
                baseWeight: exerciseSetEntity.baseWeight,
                sideWeight: exerciseSetEntity.sideWeight,
                unit: WeightUnit.kilogram,
                repetition: exerciseSetEntity.repetition,
              ),
            ),
        ),
    );
  });
}
