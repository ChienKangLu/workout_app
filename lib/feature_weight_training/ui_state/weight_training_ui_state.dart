import '../../core_view/workout_category.dart';
import '../../core_view/workout_status.dart';
import '../../model/exercise.dart';
import '../../model/unit.dart';
import '../../model/workout.dart';

abstract class WeightTrainingUiState {
  WeightTrainingUiState();

  factory WeightTrainingUiState.loading() => WeightTrainingLoadingUiState();

  factory WeightTrainingUiState.success(
    EditableWeightTraining editableWeightTraining,
  ) =>
      WeightTrainingSuccessUiState(editableWeightTraining);

  factory WeightTrainingUiState.error() => WeightTrainingErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(WeightTrainingSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is WeightTrainingLoadingUiState) {
      return onLoading();
    } else if (this is WeightTrainingSuccessUiState) {
      return onSuccess(this as WeightTrainingSuccessUiState);
    } else {
      return onError();
    }
  }
}

class WeightTrainingLoadingUiState extends WeightTrainingUiState {
  static final WeightTrainingLoadingUiState _instance =
      WeightTrainingLoadingUiState._internal();

  factory WeightTrainingLoadingUiState() {
    return _instance;
  }

  WeightTrainingLoadingUiState._internal();
}

class WeightTrainingSuccessUiState extends WeightTrainingUiState {
  WeightTrainingSuccessUiState(this.editableWeightTraining);

  final EditableWeightTraining editableWeightTraining;
}

class WeightTrainingErrorUiState extends WeightTrainingUiState {
  static final WeightTrainingErrorUiState _instance =
      WeightTrainingErrorUiState._internal();

  factory WeightTrainingErrorUiState() {
    return _instance;
  }

  WeightTrainingErrorUiState._internal();
}

class EditableWeightTraining {
  EditableWeightTraining({
    required this.number,
    required this.category,
    required this.startDateTime,
    required this.duration,
    required this.editableExercises,
    required this.workoutStatus,
    required this.weightTraining,
  });

  final int number;
  final WorkoutCategory category;
  final String startDateTime;
  final Duration duration;
  final List<EditableExercise> editableExercises;
  final WorkoutStatus workoutStatus;
  final WeightTraining weightTraining;
}

class EditableExercise {
  EditableExercise({
    required this.name,
    required this.exerciseId,
    required this.editableExerciseSets,
  });

  final String name;
  final int exerciseId;
  final List<EditableExerciseSet> editableExerciseSets;
}

class EditableExerciseSet {
  EditableExerciseSet({
    required this.exerciseId,
    required this.number,
    required this.weight,
    required this.weightUnit,
    required this.repetition,
    required this.set,
  });

  final int exerciseId;
  final int number;
  final String weight;
  final WeightUnit weightUnit;
  final int repetition;
  final WeightTrainingExerciseSet set;
}