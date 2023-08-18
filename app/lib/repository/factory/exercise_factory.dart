import '../../database/model/exercise_entity.dart';
import '../../model/exercise.dart';

class ExerciseFactory {
  static Exercise createExercise(
    ExerciseEntity exerciseEntity,
  ) {
    return Exercise(
      exerciseId: exerciseEntity.exerciseId,
      name: exerciseEntity.name,
    );
  }
}
