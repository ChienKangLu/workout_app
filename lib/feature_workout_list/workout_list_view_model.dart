import '../core_view/view_model.dart';
import '../core_view/workout_category.dart';
import '../core_view/workout_status.dart';
import '../model/result.dart';
import '../model/workout.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_repository.dart';
import 'ui_state/workout_list_ui_state.dart';

class WorkoutListViewModel extends ViewModel {
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;

  Future<Result<List<Workout>>> get _workouts =>
      _workoutRepository.getWorkouts();

  WorkoutListUiState _workoutListUiState = WorkoutListUiState.loading();
  WorkoutListUiState get workoutListUiState => _workoutListUiState;

  final _selectedReadableWorkout = <ReadableWorkout>{}; // TODO: should be view internal logic!
  int get selectedWorkoutCount => _selectedReadableWorkout.length;

  @override
  Future<void> init() async {
    await _updateWorkoutListState();
    stateChange();
  }

  @override
  Future<void> reload() async {
    if (_workoutListUiState is! WorkoutListLoadingUiState) {
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
    _workoutListUiState = WorkoutListUiState.success(
      workouts
          .map(
            (workout) => ReadableWorkout(
              workoutId: workout.workoutId,
              number: workout.typeNum + 1,
              category: WorkoutCategory.fromType(workout.type),
              exerciseThumbnails: workout.exercises
                  .map(
                    (exercise) => ExerciseThumbnail(name: exercise.name),
                  )
                  .toList(),
              workoutStatus: WorkoutStatus.fromDateTime(
                  workout.startDateTime, workout.endDateTime),
            ),
          )
          .toList(),
    );
  }

  void selectWorkout(ReadableWorkout readableWorkout) {
    final isSelected = readableWorkout.isSelected;
    if (isSelected) {
      _selectedReadableWorkout.remove(readableWorkout);
    } else {
      _selectedReadableWorkout.add(readableWorkout);
    }
    readableWorkout.isSelected = !isSelected;
    stateChange();
  }

  void unselectWorkouts() {
    for (final workoutUiState in _selectedReadableWorkout) {
      workoutUiState.isSelected = false;
    }
    _selectedReadableWorkout.clear();
    stateChange();
  }

  Future<void> deleteSelectedWorkouts() async {
    final selectedWorkoutIds = _selectedReadableWorkout
        .map((workouts) => workouts.workoutId)
        .toList(growable: false);

    _selectedReadableWorkout.clear();

    await _workoutRepository.deleteWorkouts(selectedWorkoutIds);

    reload();
  }
}
