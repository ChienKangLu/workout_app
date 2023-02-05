import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../core_view/util/date_time_display_helper.dart';
import '../core_view/workout_category.dart';
import '../core_view/workout_status.dart';
import '../model/exercise.dart';
import '../model/unit.dart';
import '../model/workout.dart';
import '../repository/exercise_repository.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_repository.dart';

class WeightTrainingViewModel extends ChangeNotifier {
  WeightTrainingViewModel({
    required this.workoutId,
  });

  final int workoutId;
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;
  final ExerciseRepository _exerciseRepository =
      RepositoryManager.instance.exerciseRepository;

  WeightTrainingUiState? _weightTrainingUiState;
  ExerciseOptionListUiState? _exerciseOptionListUiState;

  WeightTrainingUiState? get weightTrainingUiState => _weightTrainingUiState;
  ExerciseOptionListUiState? get exerciseOptionListUiState =>
      _exerciseOptionListUiState;

  Future<void> initModel() async {
    final weightTraining = await _getWeightTraining();
    _updateWeightTrainingUiState(weightTraining);

    final exercises = await _getExercises();
    _updateExerciseOptionListUiState(exercises);

    notifyListeners();
  }

  Future<WeightTraining> _getWeightTraining() async {
    final workouts = await _workoutRepository.getWorkouts(
      workoutId: workoutId,
    );
    if (workouts.isEmpty) {
      throw Exception("Workout with id '$workoutId' doesn't exist");
    }

    final workout = workouts.first;
    if (workout is! WeightTraining) {
      throw Exception("Workout with id '$workoutId' is not WeightTraining");
    }

    return workout;
  }

  Future<List<Exercise>> _getExercises() async =>
      _exerciseRepository.getExercises(WorkoutType.weightTraining);

  void _updateWeightTrainingUiState(WeightTraining weightTraining) {
    _weightTrainingUiState = _createWeightTrainingUiState(weightTraining);
  }

  WeightTrainingUiState _createWeightTrainingUiState(
    WeightTraining weightTraining,
  ) {
    return WeightTrainingUiState(
      number: weightTraining.typeNum + 1,
      category: WorkoutCategory.fromType(weightTraining.type),
      startDateTime:
          DateTimeDisplayHelper.dateTime(weightTraining.startDateTime),
      duration: _duration(weightTraining),
      exerciseListUiState: _createExerciseListUiState(weightTraining.exercises),
      workoutStatus: WorkoutStatus.fromDateTime(
        weightTraining.startDateTime,
        weightTraining.endDateTime,
      ),
      weightTraining: weightTraining,
    );
  }

  Duration _duration(WeightTraining weightTraining) {
    final startTime = weightTraining.startDateTime;
    final endTime = weightTraining.endDateTime;
    if (startTime == null || endTime == null) {
      return const Duration(hours: 0);
    }

    return endTime.difference(startTime);
  }

  WeightTrainingExerciseListUiState _createExerciseListUiState(
    List<WeightTrainingExercise> exercises,
  ) =>
      WeightTrainingExerciseListUiState(
        exerciseUiStates: exercises
            .map((exercise) => _createExerciseUiState(exercise))
            .toList(),
      );

  WeightTrainingExerciseUiState _createExerciseUiState(
    WeightTrainingExercise exercise,
  ) =>
      WeightTrainingExerciseUiState(
        name: exercise.name,
        exerciseId: exercise.exerciseId,
        exerciseSetListUiState: _createExerciseSetListUiState(exercise.sets),
      );

  WeightTrainingExerciseSetListUiState _createExerciseSetListUiState(
    List<WeightTrainingExerciseSet> sets,
  ) =>
      WeightTrainingExerciseSetListUiState(
          exerciseSetUiStates: sets
              .mapIndexed(
                  (index, set) => _createExerciseSetUiState(index + 1, set))
              .toList());

  WeightTrainingExerciseSetUiState _createExerciseSetUiState(
    int number,
    WeightTrainingExerciseSet exerciseSet,
  ) =>
      WeightTrainingExerciseSetUiState(
        number: number,
        weight: _totalWeight(exerciseSet.baseWeight, exerciseSet.sideWeight).toStringAsFixed(1),
        weightUnit: exerciseSet.unit,
        repetition: exerciseSet.repetition,
      );

  double _totalWeight(double baseWeight, double sideWeight) =>
      baseWeight + sideWeight * 2;

  void _updateExerciseOptionListUiState(List<Exercise<ExerciseSet>> exercises) {
    _exerciseOptionListUiState = _createExerciseOptionListUiState(exercises);
  }

  ExerciseOptionListUiState _createExerciseOptionListUiState(
    List<Exercise<ExerciseSet>> exercises,
  ) {
    return ExerciseOptionListUiState(
        exerciseOptionUiStates: exercises
            .map((exercise) => _createExerciseOptionUiState(exercise))
            .toList());
  }

  ExerciseOptionUiState _createExerciseOptionUiState(
    Exercise exercise,
  ) {
    return ExerciseOptionUiState(
      exerciseTypeId: exercise.exerciseId,
      name: exercise.name,
    );
  }

  Future<void> startWorkout() async {
    final weightTrainingUiState = _weightTrainingUiState;
    if (weightTrainingUiState == null) {
      return;
    }

    final weightTraining = weightTrainingUiState.weightTraining
      ..startDateTime = DateTime.now();
    final result = await _workoutRepository.updateWorkout(weightTraining);
    if (result) {
      _updateWeightTrainingUiState(weightTraining);
      notifyListeners();
    }
  }

  Future<void> finishWorkout() async {
    final weightTrainingUiState = _weightTrainingUiState;
    if (weightTrainingUiState == null) {
      return;
    }

    final weightTraining = weightTrainingUiState.weightTraining
      ..endDateTime = DateTime.now();
    final result = await _workoutRepository.updateWorkout(weightTraining);
    if (result) {
      _updateWeightTrainingUiState(weightTraining);
      notifyListeners();
    }
  }

  Future<void> createExercise(String name) async {
    final exerciseId = await _exerciseRepository.createExercise(
        WorkoutType.weightTraining, name);
    if (exerciseId == -1) {
      return;
    }

    final exercises = await _getExercises();
    _updateExerciseOptionListUiState(exercises);
    notifyListeners();
  }

  Future<void> addExercise(int exerciseId) async {
    final workoutDetailId =
        await _exerciseRepository.addExercise(workoutId, exerciseId);
    if (workoutDetailId == -1) {
      return;
    }

    final weightTraining = await _getWeightTraining();
    _updateWeightTrainingUiState(weightTraining);
    notifyListeners();
  }

  Future<void> addExerciseSet({
    required int exerciseId,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final workoutDetailId = await _exerciseRepository.addWeightTrainingSet(
      workoutId: workoutId,
      exerciseId: exerciseId,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
    );
    if (workoutDetailId == -1) {
      return;
    }

    final weightTraining = await _getWeightTraining();
    _updateWeightTrainingUiState(weightTraining);
    notifyListeners();
  }
}

class WeightTrainingExerciseSetUiState {
  WeightTrainingExerciseSetUiState({
    required this.number,
    required this.weight,
    required this.weightUnit,
    required this.repetition,
  });

  final int number;
  final String weight;
  final WeightUnit weightUnit;
  final int repetition;
}

class WeightTrainingExerciseSetListUiState {
  WeightTrainingExerciseSetListUiState({
    required this.exerciseSetUiStates,
  });

  final List<WeightTrainingExerciseSetUiState> exerciseSetUiStates;
}

class WeightTrainingExerciseUiState {
  WeightTrainingExerciseUiState({
    required this.name,
    required this.exerciseId,
    required this.exerciseSetListUiState,
  });

  final String name;
  final int exerciseId;
  final WeightTrainingExerciseSetListUiState exerciseSetListUiState;
}

class WeightTrainingExerciseListUiState {
  WeightTrainingExerciseListUiState({
    required this.exerciseUiStates,
  });

  final List<WeightTrainingExerciseUiState> exerciseUiStates;
}

class WeightTrainingUiState {
  WeightTrainingUiState({
    required this.number,
    required this.category,
    required this.startDateTime,
    required this.duration,
    required this.exerciseListUiState,
    required this.workoutStatus,
    required this.weightTraining,
  });

  final int number;
  final WorkoutCategory category;
  final String startDateTime;
  final Duration duration;
  final WeightTrainingExerciseListUiState exerciseListUiState;
  final WorkoutStatus workoutStatus;
  final WeightTraining weightTraining;
}

class ExerciseOptionUiState {
  ExerciseOptionUiState({
    required this.exerciseTypeId,
    required this.name,
  });

  final int exerciseTypeId;
  final String name;
}

class ExerciseOptionListUiState {
  ExerciseOptionListUiState({
    required this.exerciseOptionUiStates,
  });

  final List<ExerciseOptionUiState> exerciseOptionUiStates;
}
