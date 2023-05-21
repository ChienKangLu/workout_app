import '../../database/model/exercise_entity.dart';
import '../../database/model/workout_type_entity.dart';
import '../../model/exercise.dart';

class ExerciseFactory {
  static Exercise createExercise(
    ExerciseEntity exerciseEntity,
  ) {
    final exerciseId = exerciseEntity.exerciseId;
    final exerciseName = exerciseEntity.name;
    final workoutTypeEntity = exerciseEntity.workoutTypeEntity;

    final Exercise exercise;
    switch (workoutTypeEntity) {
      case WorkoutTypeEntity.weightTraining:
        exercise = WeightTrainingExercise(
          exerciseId: exerciseId,
          name: exerciseName,
        );
        break;
      case WorkoutTypeEntity.running:
        exercise = RunningExercise(
          exerciseId: exerciseId,
          name: exerciseName,
        );
        break;
    }
    return exercise;
  }
}
