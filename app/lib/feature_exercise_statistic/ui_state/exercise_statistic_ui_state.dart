abstract class ExerciseStatisticUiState {
  ExerciseStatisticUiState();

  factory ExerciseStatisticUiState.loading() =>
      ExerciseStatisticLoadingUiState();

  factory ExerciseStatisticUiState.success(
    ExerciseReport exerciseReport,
  ) =>
      ExerciseStatisticSuccessUiState(exerciseReport);

  factory ExerciseStatisticUiState.error() => ExerciseStatisticErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(ExerciseStatisticSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is ExerciseStatisticLoadingUiState) {
      return onLoading();
    } else if (this is ExerciseStatisticSuccessUiState) {
      return onSuccess(this as ExerciseStatisticSuccessUiState);
    } else {
      return onError();
    }
  }
}

class ExerciseStatisticLoadingUiState extends ExerciseStatisticUiState {
  static final ExerciseStatisticLoadingUiState _instance =
      ExerciseStatisticLoadingUiState._internal();

  factory ExerciseStatisticLoadingUiState() {
    return _instance;
  }

  ExerciseStatisticLoadingUiState._internal();
}

class ExerciseStatisticSuccessUiState extends ExerciseStatisticUiState {
  ExerciseStatisticSuccessUiState(this.exerciseReport);

  final ExerciseReport exerciseReport;
}

class ExerciseStatisticErrorUiState extends ExerciseStatisticUiState {
  static final ExerciseStatisticErrorUiState _instance =
      ExerciseStatisticErrorUiState._internal();

  factory ExerciseStatisticErrorUiState() {
    return _instance;
  }

  ExerciseStatisticErrorUiState._internal();
}

class ExerciseReport {
  ExerciseReport({
    required this.exerciseName,
    required this.monthlyMaxWeightChartData,
  });

  final String exerciseName;
  final MonthlyMaxWeightChartData monthlyMaxWeightChartData;
}

class MonthlyMaxWeightChartData {
  MonthlyMaxWeightChartData({
    required this.minWeight,
    required this.maxWeight,
    required this.monthlyMaxWeightDataList,
  });

  final double minWeight;
  final double maxWeight;
  final List<MonthlyMaxWeightData> monthlyMaxWeightDataList;

  double get range => maxWeight - minWeight;
  bool get hasData => monthlyMaxWeightDataList.isNotEmpty;
}

class MonthlyMaxWeightData {
  MonthlyMaxWeightData({
    required this.totalWeight,
    required this.endDateTime,
    required this.year,
    required this.month,
  });

  final double totalWeight;
  final int endDateTime;
  final int year;
  final int month;
}