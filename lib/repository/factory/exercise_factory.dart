import '../../database/model/embedded_object/running_with_exercise_entity.dart';
import '../../database/model/embedded_object/weight_training_with_exercise_entity.dart';
import '../../database/model/embedded_object/workout_with_exercise_entity.dart';
import '../../model/exercise.dart';

class ExerciseFactory {
  static Exercise createExercise(
    WorkoutWithExerciseEntity workoutWithExerciseEntity,
  ) {
    final Exercise exercise;
    final String exerciseName = workoutWithExerciseEntity.exerciseEntity.name;
    if (workoutWithExerciseEntity is WeightTrainingWithExerciseEntity) {
      exercise = WeightTrainingExercise(name: exerciseName);
    } else if (workoutWithExerciseEntity is RunningWithExerciseEntity) {
      exercise = RunningExercise(name: exerciseName);
    } else {
      throw Exception("$workoutWithExerciseEntity is not supported");
    }
    return exercise;
  }
}
