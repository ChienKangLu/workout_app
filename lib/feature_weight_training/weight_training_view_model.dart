import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../core_view/ui_state.dart';
import '../core_view/workout_category.dart';
import '../core_view/workout_status.dart';
import '../model/exercise.dart';
import '../model/unit.dart';
import '../model/workout.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_repository.dart';

class WeightTrainingViewModel extends ChangeNotifier {
  static final DateFormat formatter = DateFormat("MMM dd, y 'at' h:mm a");

  WeightTrainingViewModel({
    required this.workoutRecordId,
  });

  final int workoutRecordId;
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;

  UiState _uiState = UiState.loading;
  WeightTrainingUiState? _weightTrainingUiState;

  UiState get uiState => _uiState;
  WeightTrainingUiState? get weightTrainingUiState => _weightTrainingUiState;

  Future<void> initModel() async {
    final weightTraining = await _getWeightTraining();
    _updateWeightTrainingUiState(weightTraining);
  }

  Future<WeightTraining> _getWeightTraining() async {
    final workouts = await _workoutRepository.getWorkouts(
      workoutRecordId: workoutRecordId,
    );
    if (workouts.isEmpty) {
      throw Exception("Workout with id '$workoutRecordId' doesn't exist");
    }

    final workout = workouts.first;
    if (workout is! WeightTraining) {
      throw Exception(
          "Workout with id '$workoutRecordId' is not WeightTraining");
    }

    return workout;
  }

  void _updateWeightTrainingUiState(WeightTraining weightTraining) {
    _weightTrainingUiState = _createWeightTrainingUiState(weightTraining);
    _uiState = UiState.success;
    notifyListeners();
  }

  WeightTrainingUiState _createWeightTrainingUiState(
    WeightTraining weightTraining,
  ) {
    return WeightTrainingUiState(
      number: weightTraining.index + 1,
      category: WorkoutCategory.fromType(weightTraining.type),
      startDateTime: _dateTime(weightTraining),
      duration: _duration(weightTraining),
      exerciseListUiState: _createExerciseListUiState(weightTraining.exercises),
      workoutStatus: WorkoutStatus.fromDateTime(
        weightTraining.startDateTime,
        weightTraining.endDateTime,
      ),
      weightTraining: weightTraining,
    );
  }

  String _dateTime(WeightTraining weightTraining) {
    final startTime = weightTraining.startDateTime;
    if (startTime == null) {
      return "";
    }

    return formatter.format(startTime);
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
  ) {
    return WeightTrainingExerciseListUiState(
      exerciseUiStates: exercises
          .map((exercise) => _createExerciseUiState(exercise))
          .toList(),
    );
  }

  WeightTrainingExerciseUiState _createExerciseUiState(
    WeightTrainingExercise exercise,
  ) {
    return WeightTrainingExerciseUiState(
      name: exercise.name,
      exerciseSetListUiState: _createExerciseSetListUiState(exercise.sets),
    );
  }

  WeightTrainingExerciseSetListUiState _createExerciseSetListUiState(
    List<WeightTrainingExerciseSet> sets,
  ) {
    return WeightTrainingExerciseSetListUiState(
        exerciseSetUiStates: sets
            .mapIndexed(
                (index, set) => _createExerciseSetUiState(index + 1, set))
            .toList());
  }

  WeightTrainingExerciseSetUiState _createExerciseSetUiState(
    int number,
    WeightTrainingExerciseSet exerciseSet,
  ) {
    return WeightTrainingExerciseSetUiState(
      number: number,
      weight: _totalWeight(exerciseSet.baseWeight, exerciseSet.sideWeight),
      weightUnit: _displayUnitString(exerciseSet.unit),
      repetition: exerciseSet.repetition,
    );
  }

  double _totalWeight(double baseWeight, double sideWeight) {
    return baseWeight + sideWeight * 2;
  }

  String _displayUnitString(WeightUnit unit) {
    switch (unit) {
      case WeightUnit.kilogram:
        return "kg";
      case WeightUnit.pound:
        return "lb";
    }
  }

  Future<void> start() async {
    final weightTrainingUiState = _weightTrainingUiState;
    if (weightTrainingUiState == null) {
      return;
    }

    final weightTraining = weightTrainingUiState.weightTraining
      ..startDateTime = DateTime.now();
    final result = await _workoutRepository.updateWorkout(weightTraining);
    if (result) {
      _updateWeightTrainingUiState(weightTraining);
    }
  }

  Future<void> finish() async {
    final weightTrainingUiState = _weightTrainingUiState;
    if (weightTrainingUiState == null) {
      return;
    }

    final weightTraining = weightTrainingUiState.weightTraining
      ..endDateTime = DateTime.now();
    final result = await _workoutRepository.updateWorkout(weightTraining);
    if (result) {
      _updateWeightTrainingUiState(weightTraining);
    }
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
  final double weight;
  final String weightUnit;
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
    required this.exerciseSetListUiState,
  });

  final String name;
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
