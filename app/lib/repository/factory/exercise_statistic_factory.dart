import '../../database/model/exercise_statistic_entity.dart';
import '../../model/exercise_statistic.dart';

class ExerciseStatisticFactory {
  static ExerciseStatistic createExerciseStatistic(
    ExerciseStatisticEntity exerciseStatisticEntity,
  ) {
    final monthlyMaxWeightEntities =
        exerciseStatisticEntity.monthlyMaxWeightEntities;

    return ExerciseStatistic(
      monthlyMaxWeightList: monthlyMaxWeightEntities
          .map(
            (entity) => MonthlyMaxWeight(
              totalWeight: entity.totalWeight,
              endDateTime: entity.endDateTime,
              year: entity.year,
              month: entity.month,
            ),
          )
          .toList(),
    );
  }
}
