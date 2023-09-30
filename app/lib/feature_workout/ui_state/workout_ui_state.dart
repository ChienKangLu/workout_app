import '../../model/workout_status.dart';
import '../../model/exercise.dart';
import '../../model/unit.dart';
import '../../model/workout.dart';

abstract class WorkoutUiState {
  WorkoutUiState();

  factory WorkoutUiState.loading() => WorkoutLoadingUiState();

  factory WorkoutUiState.success(EditableWorkout editableWorkout) =>
      WorkoutSuccessUiState(editableWorkout);

  factory WorkoutUiState.error() => WorkoutErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(WorkoutSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is WorkoutLoadingUiState) {
      return onLoading();
    } else if (this is WorkoutSuccessUiState) {
      return onSuccess(this as WorkoutSuccessUiState);
    } else {
      return onError();
    }
  }
}

class WorkoutLoadingUiState extends WorkoutUiState {
  static final WorkoutLoadingUiState _instance =
      WorkoutLoadingUiState._internal();

  factory WorkoutLoadingUiState() {
    return _instance;
  }

  WorkoutLoadingUiState._internal();
}

class WorkoutSuccessUiState extends WorkoutUiState {
  WorkoutSuccessUiState(this.editableWorkout);

  final EditableWorkout editableWorkout;
}

class WorkoutErrorUiState extends WorkoutUiState {
  static final WorkoutErrorUiState _instance = WorkoutErrorUiState._internal();

  factory WorkoutErrorUiState() {
    return _instance;
  }

  WorkoutErrorUiState._internal();
}

class EditableWorkout {
  EditableWorkout({
    required this.startDateTimeText,
    required this.duration,
    required this.editableExercises,
    required this.workoutStatus,
    required this.workout,
  });

  final String startDateTimeText;
  final Duration duration;
  final List<EditableExercise> editableExercises;
  final WorkoutStatus workoutStatus;
  final Workout workout;
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
    required this.displayWeight,
    required this.weightUnit,
    required this.repetition,
    required this.set,
  });

  final int exerciseId;
  final int number;
  final String displayWeight;
  final WeightUnit weightUnit;
  final int repetition;
  final ExerciseSet set;
}
