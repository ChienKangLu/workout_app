import '../../database/model/exercise_set_entity.dart';
import '../../model/exercise.dart';
import '../../model/unit.dart';

class ExerciseSetFactory {
  static ExerciseSet createExerciseSet(
    ExerciseSetEntity exerciseSetEntity,
  ) {
    return ExerciseSet(
      baseWeight: exerciseSetEntity.baseWeight,
      sideWeight: exerciseSetEntity.sideWeight,
      unit: WeightUnit.kilogram,
      repetition: exerciseSetEntity.repetition,
    );
  }
}
