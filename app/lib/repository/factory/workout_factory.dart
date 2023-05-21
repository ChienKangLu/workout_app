import '../../database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import '../../model/workout.dart';
import 'exercise_factory.dart';
import 'exercise_set_factory.dart';
import 'workout_type_factory.dart';

class WorkoutFactory {
  static List<Workout> createWorkouts(
    List<WorkoutWithExercisesAndSetsEntity> workoutWithExercisesAndSetsEntities,
  ) {
    final workouts = <Workout>[];
    for (final workoutWithExercisesAndSetsEntity
        in workoutWithExercisesAndSetsEntities) {
      final workoutEntity = workoutWithExercisesAndSetsEntity.workoutEntity;
      final workoutId = workoutEntity.workoutId;
      final workoutTypeEntity = workoutEntity.workoutTypeEntity;
      final workoutTypeNum = workoutEntity.workoutTypeNum;
      final createDateTime = workoutEntity.createDateTime;

      final workoutType = WorkoutTypeFactory.fromEntity(workoutTypeEntity);

      final Workout workout;
      switch (workoutType) {
        case WorkoutType.weightTraining:
          workout = WeightTraining(
            workoutId: workoutId,
            typeNum: workoutTypeNum,
            createDateTime: DateTime.fromMillisecondsSinceEpoch(createDateTime),
          );
          break;
        case WorkoutType.running:
          workout = Running(
            workoutId: workoutId,
            typeNum: workoutTypeNum,
            createDateTime: DateTime.fromMillisecondsSinceEpoch(createDateTime),
          );
          break;
      }

      workouts.add(workout);

      final startDateTime = workoutEntity.startDateTime;
      final endDateTime = workoutEntity.endDateTime;

      workout.startDateTime = startDateTime != null
          ? DateTime.fromMillisecondsSinceEpoch(startDateTime)
          : null;
      workout.endDateTime = endDateTime != null
          ? DateTime.fromMillisecondsSinceEpoch(endDateTime)
          : null;

      final exerciseWithSetsEntityMap =
          workoutWithExercisesAndSetsEntity.exerciseWithSetsEntityMap;
      for (final exerciseWithSetsEntity in exerciseWithSetsEntityMap.values) {
        final exerciseEntity = exerciseWithSetsEntity.exerciseEntity;
        final exercise = ExerciseFactory.createExercise(exerciseEntity);
        workout.addExercise(exercise);

        final exerciseSetEntities = exerciseWithSetsEntity.exerciseSetEntities;
        for (final exerciseSetEntity in exerciseSetEntities) {
          final exerciseSet =
              ExerciseSetFactory.createExerciseSet(exerciseSetEntity);
          exercise.addSet(exerciseSet);
        }
      }
    }
    return workouts;
  }
}
