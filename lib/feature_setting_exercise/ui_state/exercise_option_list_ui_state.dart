import '../../core_view/ui_state/selectable.dart';

abstract class ExerciseOptionListUiState {
  ExerciseOptionListUiState();

  factory ExerciseOptionListUiState.loading() =>
      ExerciseOptionListLoadingUiState();

  factory ExerciseOptionListUiState.success(
    List<ExerciseOption> exerciseOptions,
  ) =>
      ExerciseOptionListSuccessUiState(exerciseOptions);

  factory ExerciseOptionListUiState.error() => ExerciseOptionListErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(ExerciseOptionListSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is ExerciseOptionListLoadingUiState) {
      return onLoading();
    } else if (this is ExerciseOptionListSuccessUiState) {
      return onSuccess(this as ExerciseOptionListSuccessUiState);
    } else {
      return onError();
    }
  }
}

class ExerciseOptionListLoadingUiState extends ExerciseOptionListUiState {
  static final ExerciseOptionListLoadingUiState _instance =
      ExerciseOptionListLoadingUiState._internal();

  factory ExerciseOptionListLoadingUiState() {
    return _instance;
  }

  ExerciseOptionListLoadingUiState._internal();
}

class ExerciseOptionListSuccessUiState extends ExerciseOptionListUiState {
  ExerciseOptionListSuccessUiState(this.exerciseOptions);

  final List<ExerciseOption> exerciseOptions;
}

class ExerciseOptionListErrorUiState extends ExerciseOptionListUiState {
  static final ExerciseOptionListErrorUiState _instance =
      ExerciseOptionListErrorUiState._internal();

  factory ExerciseOptionListErrorUiState() {
    return _instance;
  }

  ExerciseOptionListErrorUiState._internal();
}

class ExerciseOption extends Selectable {
  ExerciseOption({
    required this.exerciseId,
    required this.name,
  });

  final int exerciseId;
  final String name;
}
