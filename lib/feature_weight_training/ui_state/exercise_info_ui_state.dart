abstract class ExerciseInfoUiState {
  ExerciseInfoUiState();

  factory ExerciseInfoUiState.loading() => ExerciseInfoLoadingUiState();

  factory ExerciseInfoUiState.success(ExerciseInfo exerciseInfo) =>
      ExerciseInfoSuccessUiState(exerciseInfo);

  factory ExerciseInfoUiState.error() => ExerciseInfoErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(ExerciseInfoSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is ExerciseInfoLoadingUiState) {
      return onLoading();
    } else if (this is ExerciseInfoSuccessUiState) {
      return onSuccess(this as ExerciseInfoSuccessUiState);
    } else {
      return onError();
    }
  }
}

class ExerciseInfoLoadingUiState extends ExerciseInfoUiState {
  static final ExerciseInfoLoadingUiState _instance =
      ExerciseInfoLoadingUiState._internal();

  factory ExerciseInfoLoadingUiState() {
    return _instance;
  }

  ExerciseInfoLoadingUiState._internal();
}

class ExerciseInfoSuccessUiState extends ExerciseInfoUiState {
  ExerciseInfoSuccessUiState(this.exerciseInfo);

  final ExerciseInfo exerciseInfo;
}

class ExerciseInfoErrorUiState extends ExerciseInfoUiState {
  static final ExerciseInfoErrorUiState _instance =
      ExerciseInfoErrorUiState._internal();

  factory ExerciseInfoErrorUiState() {
    return _instance;
  }

  ExerciseInfoErrorUiState._internal();
}

class ExerciseInfo {
  ExerciseInfo({
    required this.exerciseId,
    required this.name,
    required this.max,
  });

  final int exerciseId;
  final String name;
  final double max;
}
