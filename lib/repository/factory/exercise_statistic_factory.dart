import '../../database/model/exercise_statistic_entity.dart';
import '../../model/exercise_statistic.dart';

class ExerciseStatisticFactory {
  static ExerciseStatistic createExerciseStatistic(
      ExerciseStatisticEntity exerciseStatisticEntity,
      ) {
    final name = exerciseStatisticEntity.name;
    final exerciseId = exerciseStatisticEntity.exerciseId;
    final max = exerciseStatisticEntity.max;

    return ExerciseStatistic(
      name: name,
      exerciseId: exerciseId,
      max: max,
    );
  }
}
