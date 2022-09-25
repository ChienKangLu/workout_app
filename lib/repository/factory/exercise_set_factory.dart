import '../../database/model/base_workout_entity.dart';
import '../../database/model/running_entity.dart';
import '../../database/model/weight_training_entity.dart';
import '../../model/exercise.dart';
import '../../model/unit.dart';

class ExerciseSetFactory {
  static ExerciseSet createExerciseSet(
    WorkoutEntity workoutEntity,
  ) {
    final ExerciseSet exerciseSet;
    if (workoutEntity is WeightTrainingEntity) {
      exerciseSet = WeightTrainingExerciseSet(
        baseWeight: workoutEntity.baseWeight,
        sideWeight: workoutEntity.sideWeight,
        unit: WeightUnit.kilogram,
        repetition: workoutEntity.repetition,
      );
    } else if (workoutEntity is RunningEntity) {
      exerciseSet = RunningExerciseSet(
        distance: workoutEntity.distance,
        unit: DistanceUnit.meter,
      );
    } else {
      throw Exception("$workoutEntity is not supported");
    }
    return exerciseSet;
  }
}
