import '../base_workout_entity.dart';
import '../exercise_entity.dart';

abstract class WorkoutWithExerciseEntity<T extends WorkoutEntity> {
  WorkoutWithExerciseEntity.fromMap(
      Map<String, dynamic> map, this.workoutEntity)
      : exerciseEntity = ExerciseEntity.fromMap(map);

  final ExerciseEntity exerciseEntity;
  final T workoutEntity;
}
