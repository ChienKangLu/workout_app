import 'package:collection/collection.dart';

import '../core_view/util/date_time_display_helper.dart';
import '../core_view/view_model.dart';
import '../core_view/workout_category.dart';
import '../core_view/workout_status.dart';
import '../model/exercise.dart';
import '../model/result.dart';
import '../model/workout.dart';
import '../repository/exercise_repository.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_repository.dart';
import '../use_case/exercise_use_case.dart';
import '../util/log_util.dart';
import 'ui_state/exercise_option_list_ui_state.dart';
import 'ui_state/weight_training_ui_state.dart';

class WeightTrainingViewModel extends ViewModel {
  static const _tag = "WeightTrainingViewModel";

  WeightTrainingViewModel({
    required this.workoutId,
  });

  final int workoutId;
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;
  final ExerciseRepository _exerciseRepository =
      RepositoryManager.instance.exerciseRepository;
  final ExerciseUseCase _exerciseUseCase = ExerciseUseCase();

  WeightTrainingUiState _weightTrainingUiState =
      WeightTrainingUiState.loading();
  WeightTrainingUiState get weightTrainingUiState => _weightTrainingUiState;

  ExerciseOptionListUiState _exerciseOptionListUiState =
      ExerciseOptionListUiState.loading();
  ExerciseOptionListUiState get exerciseOptionListUiState =>
      _exerciseOptionListUiState;

  @override
  Future<void> init() async {
    await _updateWeightTrainingUiState();
    await _updateExerciseOptionListUiState();
    stateChange();
  }

  Future<void> _updateWeightTrainingUiState() async {
    final weightTraining = await _getWeightTraining();
    if (weightTraining == null) {
      _weightTrainingUiState = WeightTrainingUiState.error();
      return;
    }

    _weightTrainingUiState = WeightTrainingUiState.success(
      EditableWeightTraining(
        number: weightTraining.typeNum + 1,
        category: WorkoutCategory.fromType(weightTraining.type),
        startDateTimeText:
            DateTimeDisplayHelper.dateTime(weightTraining.startDateTime),
        duration: _duration(weightTraining),
        editableExercises: weightTraining.exercises
            .map(
              (exercise) => EditableExercise(
                name: exercise.name,
                exerciseId: exercise.exerciseId,
                editableExerciseSets: exercise.sets
                    .mapIndexed(
                      (index, set) => EditableExerciseSet(
                        exerciseId: exercise.exerciseId,
                        number: index + 1,
                        weight: _totalWeight(set).toStringAsFixed(1),
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
          weightTraining.startDateTime,
          weightTraining.endDateTime,
        ),
        weightTraining: weightTraining,
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

  Future<WeightTraining?> _getWeightTraining() async {
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

    final workout = workouts.first;
    if (workout is! WeightTraining) {
      Log.e(_tag, "Workout with id '$workoutId' is not WeightTraining");
      return null;
    }

    return workout;
  }

  Future<void> startWorkout(
    EditableWeightTraining editableWeightTraining,
  ) async {
    final weightTraining = editableWeightTraining.weightTraining
      ..startDateTime = DateTime.now();

    final result = await _workoutRepository.updateWorkout(weightTraining);
    if (result is Success) {
      await _updateWeightTrainingUiState();
      stateChange();
    }
  }

  Future<void> finishWorkout(
    EditableWeightTraining editableWeightTraining,
  ) async {
    final weightTraining = editableWeightTraining.weightTraining
      ..endDateTime = DateTime.now();

    final result = await _workoutRepository.updateWorkout(weightTraining);
    if (result is Success) {
      await _updateWeightTrainingUiState();
      stateChange();
    }
  }

  Future<void> createExercise(String name) async {
    final result = await _exerciseUseCase.createExercise(name);
    if (result == false) {
      return;
    }

    await _updateExerciseOptionListUiState();
    stateChange();
  }

  Future<void> addExercise(int exerciseId) async {
    final result = await _exerciseRepository.addExercise(workoutId, exerciseId);
    if (result is Error) {
      return;
    }

    await _updateWeightTrainingUiState();
    stateChange();
  }

  Future<void> removeExerciseFromWorkout(int exerciseId) async {
    final result =
        await _exerciseRepository.removeExerciseFromWorkout(workoutId, exerciseId);
    if (result is Error) {
      return;
    }

    await _updateWeightTrainingUiState();
    stateChange();
  }

  Future<void> addExerciseSet({
    required int exerciseId,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final result = await _exerciseRepository.addWeightTrainingSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
    );
    if (result is Error) {
      return;
    }

    await _updateWeightTrainingUiState();
    stateChange();
  }

  Future<void> updateExerciseSet({
    required int exerciseId,
    required int setNum,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final result = await _exerciseRepository.updateWeightTrainingSet(
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

    await _updateWeightTrainingUiState();
    stateChange();
  }

  Future<void> removeExerciseSet({
    required int exerciseId,
    required int setNum,
  }) async {
    final result = await _exerciseRepository.removeWeightTrainingSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNum: setNum,
    );
    if (result is Error) {
      return;
    }

    await _updateWeightTrainingUiState();
    stateChange();
  }

  double _totalWeight(WeightTrainingExerciseSet set) =>
      set.baseWeight + set.sideWeight * 2;

  Duration _duration(WeightTraining weightTraining) {
    final startTime = weightTraining.startDateTime;
    final endTime = weightTraining.endDateTime;
    if (startTime == null || endTime == null) {
      return const Duration(hours: 0);
    }

    return endTime.difference(startTime);
  }
}
