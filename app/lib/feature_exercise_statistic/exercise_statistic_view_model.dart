import 'dart:math';

import '../core_view/view_model.dart';
import '../use_case/exercise_use_case.dart';
import '../util/number_util.dart';
import 'ui_state/exercise_statistic_ui_state.dart';

class ExerciseStatisticViewModel extends ViewModel {
  static const _tag = "ExerciseStatisticViewModel";

  ExerciseStatisticViewModel({
    required this.exerciseId,
  });

  final int exerciseId;
  final ExerciseUseCase _exerciseUseCase = ExerciseUseCase();

  ExerciseStatisticUiState _exerciseStatisticUiState =
      ExerciseStatisticUiState.loading();
  ExerciseStatisticUiState get exerciseStatisticUiState =>
      _exerciseStatisticUiState;

  @override
  Future<void> init() async {
    await _updateExerciseStatisticUiState();
    stateChange();
  }

  Future<void> _updateExerciseStatisticUiState() async {
    final exerciseStatistic = await _exerciseUseCase.getStatistic(exerciseId);
    final exercise = await _exerciseUseCase.getExercise(exerciseId);
    if (exercise == null || exerciseStatistic == null) {
      _exerciseStatisticUiState = ExerciseStatisticUiState.error();
      return;
    }

    _exerciseStatisticUiState = ExerciseStatisticUiState.success(ExerciseReport(
      exerciseName: exercise.name,
      monthlyMaxWeightChartData: MonthlyMaxWeightChartData(
        minWeight: exerciseStatistic.monthlyMaxWeightList
            .map((monthlyMaxWeight) => monthlyMaxWeight.totalWeight)
            .fold(double.maxFinite, min),
        maxWeight: exerciseStatistic.monthlyMaxWeightList
            .map((monthlyMaxWeight) => monthlyMaxWeight.totalWeight)
            .fold(0, max),
        monthlyMaxWeightDataList: exerciseStatistic.monthlyMaxWeightList
            .map(
              (monthlyMaxWeight) => MonthlyMaxWeightData(
                totalWeight:
                    NumberUtil.toPrecision(monthlyMaxWeight.totalWeight, 2),
                endDateTime: monthlyMaxWeight.endDateTime,
                year: monthlyMaxWeight.year,
                month: monthlyMaxWeight.month,
              ),
            )
            .toList(),
      ),
    ));
  }
}
