import '../../core_view/workout_category.dart';
import '../../core_view/workout_status.dart';

abstract class WorkoutListUiState {
  WorkoutListUiState();

  factory WorkoutListUiState.loading() => WorkoutListLoadingUiState();

  factory WorkoutListUiState.success(List<ReadableWorkout> readableWorkouts) =>
      WorkoutListSuccessUiState(readableWorkouts);

  factory WorkoutListUiState.error() => WorkoutListErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(WorkoutListSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is WorkoutListLoadingUiState) {
      return onLoading();
    } else if (this is WorkoutListSuccessUiState) {
      return onSuccess(this as WorkoutListSuccessUiState);
    } else {
      return onError();
    }
  }
}

class WorkoutListLoadingUiState extends WorkoutListUiState {
  static final WorkoutListLoadingUiState _instance =
      WorkoutListLoadingUiState._internal();

  factory WorkoutListLoadingUiState() {
    return _instance;
  }

  WorkoutListLoadingUiState._internal();
}

class WorkoutListSuccessUiState extends WorkoutListUiState {
  WorkoutListSuccessUiState(this.readableWorkouts);

  final List<ReadableWorkout> readableWorkouts;
}

class WorkoutListErrorUiState extends WorkoutListUiState {
  static final WorkoutListErrorUiState _instance =
      WorkoutListErrorUiState._internal();

  factory WorkoutListErrorUiState() {
    return _instance;
  }

  WorkoutListErrorUiState._internal();
}

class ReadableWorkout {
  ReadableWorkout({
    required this.workoutId,
    required this.number,
    required this.category,
    required this.day,
    required this.date,
    required this.exerciseThumbnails,
    required this.workoutStatus,
  });

  final int workoutId;
  final int number;
  final WorkoutCategory category;
  final String day;
  final String date;
  final List<ExerciseThumbnail> exerciseThumbnails;
  final WorkoutStatus workoutStatus;

  bool isSelected = false;
}

class ExerciseThumbnail {
  ExerciseThumbnail({
    required this.name,
  });

  final String name;
}
