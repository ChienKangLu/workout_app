import '../../database/model/embedded_object/workout_with_exercise_entity.dart';
import '../../database/model/workout_record_entity.dart';
import '../../database/model/workout_type_entity.dart';
import '../../model/exercise.dart';
import '../../model/workout.dart';
import 'exercise_factory.dart';
import 'exercise_set_factory.dart';
import 'workout_type_factory.dart';

typedef _WorkoutRecordIdTye = int;
typedef _ExercisesMapType = Map<String, Exercise>;

class WorkoutFactory {
  static List<Workout> createWorkouts(
    List<WorkoutRecordEntity> workoutRecordEntities,
    List<WorkoutWithExerciseEntity> workoutWithExerciseEntities,
  ) {
    final workoutMap = _createWorkoutMap(workoutRecordEntities);
    final exercisesMap = _createExercisesMap(workoutWithExerciseEntities);
    return _createWorkouts(workoutMap, exercisesMap);
  }

  static Map<int, Workout> _createWorkoutMap(
      List<WorkoutRecordEntity> workoutRecordEntities) {
    if (workoutRecordEntities.isEmpty) {
      return {};
    }

    final workouts = <int, Workout>{};
    for (final workoutRecordEntity in workoutRecordEntities) {
      final Workout workout = _createWorkout(workoutRecordEntity);
      workouts[workout.workoutRecordId] = workout;
    }
    return workouts;
  }

  static Workout _createWorkout(WorkoutRecordEntity workoutRecordEntity) {
    final workoutRecordId = workoutRecordEntity.workoutRecordId;
    final workoutTypeId = workoutRecordEntity.workoutTypeId;
    final workoutTypeIndex = workoutRecordEntity.workoutTypeIndex;
    final createDateTime = workoutRecordEntity.createDateTime;
    final workoutTypeEntity = WorkoutTypeEntity.fromId(workoutTypeId);
    final workoutType = WorkoutTypeFactory.fromEntity(workoutTypeEntity);

    final Workout workout;
    switch (workoutType) {
      case WorkoutType.weightTraining:
        workout = WeightTraining(
          workoutRecordId: workoutRecordId,
          index: workoutTypeIndex,
          createDateTime: DateTime.fromMicrosecondsSinceEpoch(createDateTime),
        );
        break;
      case WorkoutType.running:
        workout = Running(
          workoutRecordId: workoutRecordId,
          index: workoutTypeIndex,
          createDateTime: DateTime.fromMicrosecondsSinceEpoch(createDateTime),
        );
        break;
    }

    final startDateTime = workoutRecordEntity.startDateTime;
    final endDateTime = workoutRecordEntity.endDateTime;

    workout.startDateTime = startDateTime != null
        ? DateTime.fromMicrosecondsSinceEpoch(startDateTime)
        : null;
    workout.endDateTime = endDateTime != null
        ? DateTime.fromMicrosecondsSinceEpoch(endDateTime)
        : null;

    return workout;
  }

  static Map<_WorkoutRecordIdTye, _ExercisesMapType> _createExercisesMap(
    List<WorkoutWithExerciseEntity> workoutWithExerciseEntities,
  ) {
    if (workoutWithExerciseEntities.isEmpty) {
      return {};
    }

    final exercisesMap = <int, _ExercisesMapType>{};
    for (final workoutWithExerciseEntity in workoutWithExerciseEntities) {
      final workoutRecordId =
          workoutWithExerciseEntity.workoutEntity.workoutRecordId;

      final _ExercisesMapType exercises;
      if (exercisesMap.containsKey(workoutRecordId)) {
        exercises = exercisesMap[workoutRecordId]!;
      } else {
        exercises = {};
        exercisesMap[workoutRecordId] = exercises;
      }

      final Exercise exercise;
      final exerciseName = workoutWithExerciseEntity.exerciseEntity.name;
      if (exercises.containsKey(exerciseName)) {
        exercise = exercises[exerciseName]!;
      } else {
        exercise = ExerciseFactory.createExercise(workoutWithExerciseEntity);
        exercises[exerciseName] = exercise;
      }

      final ExerciseSet exerciseSet = ExerciseSetFactory.createExerciseSet(
        workoutWithExerciseEntity.workoutEntity,
      );
      exercise.addSet(exerciseSet);
    }

    return exercisesMap;
  }

  static _createWorkouts(
    Map<int, Workout> workoutMap,
    Map<int, _ExercisesMapType> exercisesMap,
  ) {
    for (final entry in exercisesMap.entries) {
      final workoutRecordId = entry.key;
      final workout = workoutMap[workoutRecordId];
      if (workout == null) {
        continue;
      }

      final exercises = entry.value;
      for (final exercise in exercises.values) {
        workout.addExercise(exercise);
      }
    }
    return workoutMap.values.toList();
  }
}
