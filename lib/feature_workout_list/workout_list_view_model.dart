import '../core_view/ui_state.dart';
import '../core_view/view_model.dart';
import '../core_view/workout_category.dart';
import '../core_view/workout_status.dart';
import '../model/exercise.dart';
import '../model/result.dart';
import '../model/workout.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_repository.dart';

class WorkoutListViewModel extends ViewModel {
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;

  Future<Result<List<Workout>>> get _workouts =>
      _workoutRepository.getWorkouts();

  WorkoutListUiState _workoutListUiState = WorkoutListUiState.loading();
  WorkoutListUiState get workoutListUiState => _workoutListUiState;

  @override
  Future<void> init() async {
    await update();
  }

  @override
  Future<void> update() async {
    if (_workoutListUiState.isLoading == false) {
      _workoutListUiState = WorkoutListUiState.loading();
      stateChange();
    }

    await _updateWorkoutListState();
    stateChange();
  }

  Future<void> _updateWorkoutListState() async {
    final result = await _workouts;
    if (result is Error) {
      _workoutListUiState = WorkoutListUiState.error();
      return;
    }

    final workouts = (result as Success<List<Workout>>).data;
    _workoutListUiState = WorkoutListUiState.success(workouts);
  }
}

class ExerciseThumbnailUiState extends UiState {
  ExerciseThumbnailUiState._({
    required super.status,
    required this.name,
  });

  final String name;

  ExerciseThumbnailUiState.from(Exercise exercise)
      : this._(
          status: UiStatus.success,
          name: exercise.name,
        );
}

class ExerciseThumbnailListUiState extends UiState {
  ExerciseThumbnailListUiState._({
    required super.status,
    required this.exerciseThumbnails,
  });

  final List<ExerciseThumbnailUiState> exerciseThumbnails;

  ExerciseThumbnailListUiState.from(List<Exercise> exercises)
      : this._(
          status: UiStatus.success,
          exerciseThumbnails: exercises
              .map((exercise) => ExerciseThumbnailUiState.from(exercise))
              .toList(),
        );
}

class WorkoutUiState extends UiState {
  WorkoutUiState._({
    required super.status,
    required this.workoutId,
    required this.number,
    required this.category,
    required this.exerciseThumbnailList,
    required this.workoutStatus,
  });

  final int workoutId;
  final int number;
  final WorkoutCategory category;
  final ExerciseThumbnailListUiState exerciseThumbnailList;
  final WorkoutStatus workoutStatus;

  WorkoutUiState.success(Workout workout)
      : this._(
          status: UiStatus.success,
          workoutId: workout.workoutId,
          number: workout.typeNum + 1,
          category: WorkoutCategory.fromType(workout.type),
          exerciseThumbnailList:
              ExerciseThumbnailListUiState.from(workout.exercises),
          workoutStatus: WorkoutStatus.fromDateTime(
              workout.startDateTime, workout.endDateTime),
        );
}

class WorkoutListUiState extends UiState {
  WorkoutListUiState._({
    required super.status,
    required this.workouts,
  });

  final List<WorkoutUiState> workouts;

  WorkoutListUiState.loading()
      : this._(
          status: UiStatus.loading,
          workouts: [],
        );

  WorkoutListUiState.success(List<Workout> workouts)
      : this._(
          status: UiStatus.success,
          workouts: workouts
              .map((workout) => WorkoutUiState.success(workout))
              .toList(),
        );

  WorkoutListUiState.error()
      : this._(
          status: UiStatus.error,
          workouts: [],
        );
}
