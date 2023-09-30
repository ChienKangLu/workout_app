import 'package:collection/collection.dart';

import '../util/date_time_util.dart';
import '../core_view/view_model.dart';
import '../model/workout_status.dart';
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

  final _selectedReadableWorkout = <ReadableWorkout>{};
  int get selectedWorkoutCount => _selectedReadableWorkout.length;

  @override
  Future<void> init() async {
    await super.init();
    await _updateWorkoutListState();
    stateChange();
  }

  @override
  Future<void> reload({
    bool isLongOperation = false,
  }) async {
    if (_workoutListUiState is! WorkoutListLoadingUiState &&
        isLongOperation) {
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
    final total = workouts.length;
    _workoutListUiState = WorkoutListUiState.success(
      workouts
          .mapIndexed(
            (index, workout) => ReadableWorkout(
              workoutId: workout.workoutId,
              number: total - index,
              day: DateTimeUtil.dayString(
                  workout.startDateTime ?? workout.createDateTime),
              date: DateTimeUtil.dateString(
                  workout.startDateTime ?? workout.createDateTime),
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

  Future<int?> createWorkout() async {
    final result = await _workoutRepository.createWorkout();
    if (result is Error) {
      return null;
    }

    return (result as Success<int>).data;
  }
}
