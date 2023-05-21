import '../../database/model/exercise_set_entity.dart';
import '../../database/model/running_set_entity.dart';
import '../../database/model/weight_training_set_entity.dart';
import '../../model/exercise.dart';
import '../../model/unit.dart';

class ExerciseSetFactory {
  static ExerciseSet createExerciseSet(
    ExerciseSetEntity exerciseSetEntity,
  ) {
    final ExerciseSet exerciseSet;
    if (exerciseSetEntity is WeightTrainingSetEntity) {
      exerciseSet = WeightTrainingExerciseSet(
        baseWeight: exerciseSetEntity.baseWeight,
        sideWeight: exerciseSetEntity.sideWeight,
        unit: WeightUnit.kilogram,
        repetition: exerciseSetEntity.repetition,
      );
    } else if (exerciseSetEntity is RunningSetEntity) {
      exerciseSet = RunningExerciseSet(
        distance: exerciseSetEntity.distance,
        unit: DistanceUnit.meter,
      );
    } else {
      throw Exception("$exerciseSetEntity is not supported");
    }
    return exerciseSet;
  }
}
