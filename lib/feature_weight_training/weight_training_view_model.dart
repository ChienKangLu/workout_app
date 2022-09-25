import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import '../model/exercise.dart';
import '../model/unit.dart';
import '../model/workout.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_repository.dart';

class WeightTrainingViewModel {
  static final DateFormat formatter = DateFormat("MMM dd, y 'at' h:mm a");

  WeightTrainingViewModel({
    required this.workoutRecordId,
  });

  final int workoutRecordId;
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;

  Future<WeightTraining> get _weightTraining async {
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

  Future<WeightTrainingUiState> get weightTrainingState async {
    return _toWeightTrainingUiState(await _weightTraining);
  }

  WeightTrainingUiState _toWeightTrainingUiState(
      WeightTraining weightTraining) {
    return WeightTrainingUiState(
      name: weightTraining.index.toString(),
      dateTime: dateTime(weightTraining),
      duration: duration(weightTraining),
      exerciseListUiState:
          _toWeightTrainingExerciseListUiState(weightTraining.exercises),
    );
  }

  String dateTime(WeightTraining weightTraining) {
    final startTime = weightTraining.startDateTime;
    if (startTime == null) {
      return "";
    }

    return formatter.format(startTime);
  }

  Duration duration(WeightTraining weightTraining) {
    final startTime = weightTraining.startDateTime;
    final endTime = weightTraining.endDateTime;
    if (startTime == null || endTime == null) {
      return const Duration(hours: 0);
    }

    return endTime.difference(startTime);
  }

  WeightTrainingExerciseListUiState _toWeightTrainingExerciseListUiState(
    List<WeightTrainingExercise> exercises,
  ) {
    return WeightTrainingExerciseListUiState(
      exercises: exercises
          .map((exercise) => _toWeightTrainingExerciseUiState(exercise))
          .toList(),
    );
  }

  WeightTrainingExerciseUiState _toWeightTrainingExerciseUiState(
    WeightTrainingExercise exercise,
  ) {
    return WeightTrainingExerciseUiState(
      name: exercise.name,
      setList: _toWeightTrainingExerciseSetListUiState(exercise.sets),
    );
  }

  WeightTrainingExerciseSetListUiState _toWeightTrainingExerciseSetListUiState(
    List<WeightTrainingExerciseSet> sets,
  ) {
    return WeightTrainingExerciseSetListUiState(
        sets: sets
            .mapIndexed((index, set) =>
                _toWeightTrainingExerciseSetUiState(index + 1, set))
            .toList());
  }

  WeightTrainingExerciseSetUiState _toWeightTrainingExerciseSetUiState(
    int number,
    WeightTrainingExerciseSet exerciseSet,
  ) {
    return WeightTrainingExerciseSetUiState(
      number: number,
      weight: _totalWeight(exerciseSet.baseWeight, exerciseSet.sideWeight),
      weightUnit: displayUnitString(exerciseSet.unit),
      repetition: exerciseSet.repetition,
    );
  }

  double _totalWeight(double baseWeight, double sideWeight) {
    return baseWeight + sideWeight * 2;
  }

  String displayUnitString(WeightUnit unit) {
    switch (unit) {
      case WeightUnit.kilogram:
        return "kg";
      case WeightUnit.pound:
        return "lb";
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
    required this.sets,
  });

  final List<WeightTrainingExerciseSetUiState> sets;
}

class WeightTrainingExerciseUiState {
  WeightTrainingExerciseUiState({
    required this.name,
    required this.setList,
  });

  final String name;
  final WeightTrainingExerciseSetListUiState setList;
}

class WeightTrainingExerciseListUiState {
  WeightTrainingExerciseListUiState({
    required this.exercises,
  });

  final List<WeightTrainingExerciseUiState> exercises;
}

class WeightTrainingUiState {
  WeightTrainingUiState({
    required this.name,
    required this.dateTime,
    required this.duration,
    required this.exerciseListUiState,
  });

  final String name;
  final String dateTime;
  final Duration duration;
  final WeightTrainingExerciseListUiState exerciseListUiState;
}
