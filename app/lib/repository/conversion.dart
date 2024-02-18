import '../database/dao/dao_result.dart';
import '../database/model/embedded_object/exercise_statistic_entity.dart';
import '../database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import '../database/model/exercise_entity.dart';
import '../database/model/exercise_set_entity.dart';
import '../database/model/water_goal_entity.dart';
import '../database/model/water_log_entity.dart';
import '../database/model/workout_entity.dart';
import '../model/exercise.dart';
import '../model/exercise_statistic.dart';
import '../model/result.dart';
import '../model/unit.dart';
import '../model/water_goal.dart';
import '../model/water_log.dart';
import '../model/workout.dart';

extension WorkoutConversion on Workout {
  WorkoutEntity asWorkoutEntity() => WorkoutEntity(
        workoutId: workoutId,
        createDateTime: createDateTime.millisecondsSinceEpoch,
        startDateTime: startDateTime?.millisecondsSinceEpoch,
        endDateTime: endDateTime?.millisecondsSinceEpoch,
      );
}

extension DaoResultConversion<T> on DaoResult<T> {
  Result<R> asResult<R>({R Function(T data)? convert}) {
    final it = this;
    if (it is DaoSuccess<T>) {
      final R convertedData;

      if (convert != null) {
        convertedData = convert(it.data);
      } else {
        convertedData = it.data as R;
      }

      return Success<R>(convertedData);
    }
    return Error((it as DaoError<T>).exception);
  }
}

extension ExerciseConversion on ExerciseEntity {
  Exercise asExercise() => Exercise(
        exerciseId: exerciseId,
        name: name,
      );
}

extension ExerciseSetConversion on ExerciseSetEntity {
  ExerciseSet asExerciseSet() => ExerciseSet(
        baseWeight: baseWeight,
        sideWeight: sideWeight,
        unit: WeightUnit.kilogram,
        repetition: repetition,
      );
}

extension ExerciseStatisticEntityConversion on ExerciseStatisticEntity {
  ExerciseStatistic asExerciseStatistic() => ExerciseStatistic(
        monthlyMaxWeightList: monthlyMaxWeightEntities
            .map(
              (entity) => MonthlyMaxWeight(
                totalWeight: entity.totalWeight,
                endDateTime: entity.endDateTime,
                year: entity.year,
                month: entity.month,
              ),
            )
            .toList(),
      );
}

extension WaterGoalEntityConversion on WaterGoalEntity {
  WaterGoal asWaterGoal() => WaterGoal(
        id: id,
        volume: volume,
        dateTime: DateTime.fromMillisecondsSinceEpoch(dateTime),
      );
}

extension WaterLogEntityConversion on WaterLogEntity {
  WaterLog asWaterLog() => WaterLog(
        id: id,
        volume: volume,
        dateTime: DateTime.fromMillisecondsSinceEpoch(dateTime),
      );
}

extension WorkoutWithExercisesAndSetsEntityConversion
    on WorkoutWithExercisesAndSetsEntity {
  Workout asWorkout() {
    final workoutId = workoutEntity.workoutId;
    final createDateTime = workoutEntity.createDateTime;
    final startDateTime = workoutEntity.startDateTime;
    final endDateTime = workoutEntity.endDateTime;

    final workout = Workout(
      workoutId: workoutId,
      createDateTime: DateTime.fromMillisecondsSinceEpoch(createDateTime),
      startDateTime: startDateTime != null
          ? DateTime.fromMillisecondsSinceEpoch(startDateTime)
          : null,
      endDateTime: endDateTime != null
          ? DateTime.fromMillisecondsSinceEpoch(endDateTime)
          : null,
    );

    for (final exerciseWithSetsEntity in exerciseWithSetsEntityMap.values) {
      final exerciseEntity = exerciseWithSetsEntity.exerciseEntity;
      final exercise = exerciseEntity.asExercise();
      workout.addExercise(exercise);

      final exerciseSetEntities = exerciseWithSetsEntity.exerciseSetEntities;
      for (final exerciseSetEntity in exerciseSetEntities) {
        final exerciseSet = exerciseSetEntity.asExerciseSet();
        exercise.addSet(exerciseSet);
      }
    }

    return workout;
  }
}
