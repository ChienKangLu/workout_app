import 'interval_event.dart';
import 'unit.dart';

abstract class Exercise<T extends ExerciseSet> extends IntervalEvent {
  Exercise({
    required this.exerciseId,
    required this.name,
    List<T>? sets,
  }) : sets = sets ?? [];

  final int exerciseId;
  final String name;
  final List<T> sets;

  void addSet(T set) {
    sets.add(set);
  }
}

abstract class ExerciseSet extends IntervalEvent {}

class WeightTrainingExercise extends Exercise<WeightTrainingExerciseSet> {
  WeightTrainingExercise({
    required super.exerciseId,
    required super.name,
    List<WeightTrainingExerciseSet>? sets,
  }) : super(sets: sets);
}

class WeightTrainingExerciseSet extends ExerciseSet {
  WeightTrainingExerciseSet({
    required this.baseWeight,
    required this.sideWeight,
    required this.unit,
    required this.repetition,
  });

  final double baseWeight;
  final double sideWeight;
  final WeightUnit unit;
  final int repetition;
}

class RunningExercise extends Exercise<RunningExerciseSet> {
  RunningExercise({
    required super.exerciseId,
    required super.name,
    List<RunningExerciseSet>? sets,
  }) : super(sets: sets);
}

class RunningExerciseSet extends ExerciseSet {
  RunningExerciseSet({
    required this.distance,
    required this.unit,
  });

  final double distance;
  final DistanceUnit unit;
}
