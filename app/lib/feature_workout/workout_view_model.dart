import 'package:collection/collection.dart';

import '../core_view/util/date_time_display_helper.dart';
import '../core_view/util/weight_display_helper.dart';
import '../core_view/view_model.dart';
import '../core_view/workout_status.dart';
import '../model/result.dart';
import '../model/workout.dart';
import '../repository/exercise_repository.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_repository.dart';
import '../use_case/exercise_use_case.dart';
import '../util/log_util.dart';
import 'ui_state/exercise_option_list_ui_state.dart';
import 'ui_state/workout_ui_state.dart';

class WorkoutViewModel extends ViewModel {
  static const _tag = "WorkoutViewModel";

  WorkoutViewModel({
    required this.workoutId,
  });

  final int workoutId;
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;
  final ExerciseRepository _exerciseRepository =
      RepositoryManager.instance.exerciseRepository;
  final ExerciseUseCase _exerciseUseCase = ExerciseUseCase();

  WorkoutUiState _workoutUiState = WorkoutUiState.loading();
  WorkoutUiState get workoutUiState => _workoutUiState;

  ExerciseOptionListUiState _exerciseOptionListUiState =
      ExerciseOptionListUiState.loading();
  ExerciseOptionListUiState get exerciseOptionListUiState =>
      _exerciseOptionListUiState;

  @override
  Future<void> init() async {
    await _updateWorkoutUiState();
    await _updateExerciseOptionListUiState();
    stateChange();
  }

  Future<void> _updateWorkoutUiState() async {
    final workout = await _getWorkout();
    if (workout == null) {
      _workoutUiState = WorkoutUiState.error();
      return;
    }

    _workoutUiState = WorkoutUiState.success(
      EditableWorkout(
        startDateTimeText:
            DateTimeDisplayHelper.dateTime(workout.startDateTime),
        duration: _duration(workout),
        editableExercises: workout.exercises
            .map(
              (exercise) => EditableExercise(
                name: exercise.name,
                exerciseId: exercise.exerciseId,
                editableExerciseSets: exercise.sets
                    .mapIndexed(
                      (index, set) => EditableExerciseSet(
                        exerciseId: exercise.exerciseId,
                        number: index + 1,
                        displayWeight: set.displayTotalWeight(),
                        weightUnit: set.unit,
                        repetition: set.repetition,
                        set: set,
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
        workoutStatus: WorkoutStatus.fromDateTime(
          workout.startDateTime,
          workout.endDateTime,
        ),
        workout: workout,
      ),
    );
  }

  Future<void> _updateExerciseOptionListUiState() async {
    final exercises = await _exerciseUseCase.getExercises();
    if (exercises == null) {
      _exerciseOptionListUiState = ExerciseOptionListUiState.error();
      return;
    }

    _exerciseOptionListUiState = ExerciseOptionListUiState.success(
      exercises
          .map(
            (exercise) => ExerciseOption(
              exerciseId: exercise.exerciseId,
              name: exercise.name,
            ),
          )
          .toList(),
    );
  }

  Future<Workout?> _getWorkout() async {
    final Result<List<Workout>> result = await _workoutRepository.getWorkouts(
      workoutIds: [workoutId],
    );

    if (result is Error<List<Workout>>) {
      Log.e(_tag, "Error happens while get weight training", result.exception);
      return null;
    }

    final workouts = (result as Success<List<Workout>>).data;

    if (workouts.isEmpty) {
      Log.e(_tag, "Workout with id '$workoutId' doesn't exist");
      return null;
    }

    return workouts.first;
  }

  Future<void> startWorkout(EditableWorkout editableWorkout) async {
    final workout = editableWorkout.workout..startDateTime = DateTime.now();

    final result = await _workoutRepository.updateWorkout(workout);
    if (result is Success) {
      await _updateWorkoutUiState();
      stateChange();
    }
  }

  Future<void> finishWorkout(EditableWorkout editableWorkout) async {
    final workout = editableWorkout.workout..endDateTime = DateTime.now();

    final result = await _workoutRepository.updateWorkout(workout);
    if (result is Success) {
      await _updateWorkoutUiState();
      stateChange();
    }
  }

  Future<int?> createExercise(
    String name, {
    bool updateState = false,
  }) async {
    final exerciseId = await _exerciseUseCase.createExercise(name);
    if (exerciseId == null) {
      return null;
    }

    if (updateState) {
      await _updateExerciseOptionListUiState();
      stateChange();
    }

    return exerciseId;
  }

  Future<void> addExercise(int exerciseId) async {
    final result = await _exerciseRepository.addExercise(workoutId, exerciseId);
    if (result is Error) {
      return;
    }

    await _updateWorkoutUiState();
    stateChange();
  }

  Future<void> removeExerciseFromWorkout(int exerciseId) async {
    final result = await _exerciseRepository.removeExerciseFromWorkout(
        workoutId, exerciseId);
    if (result is Error) {
      return;
    }

    await _updateWorkoutUiState();
    stateChange();
  }

  Future<void> addExerciseSet({
    required int exerciseId,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final result = await _exerciseRepository.addExerciseSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
    );
    if (result is Error) {
      return;
    }

    await _updateWorkoutUiState();
    stateChange();
  }

  Future<void> updateExerciseSet({
    required int exerciseId,
    required int setNum,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final result = await _exerciseRepository.updateExerciseSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
    );
    if (result is Error) {
      return;
    }

    await _updateWorkoutUiState();
    stateChange();
  }

  Future<void> removeExerciseSet({
    required int exerciseId,
    required int setNum,
  }) async {
    final result = await _exerciseRepository.removeExerciseSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
    );
    if (result is Error) {
      return;
    }

    await _updateWorkoutUiState();
    stateChange();
  }

  Duration _duration(Workout workout) {
    final startTime = workout.startDateTime;
    final endTime = workout.endDateTime;
    if (startTime == null || endTime == null) {
      return const Duration(hours: 0);
    }

    return endTime.difference(startTime);
  }
}
