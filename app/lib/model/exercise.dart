import 'interval_event.dart';
import 'unit.dart';

class Exercise extends IntervalEvent {
  Exercise({
    required this.exerciseId,
    required this.name,
    List<ExerciseSet>? sets,
  }) : sets = sets ?? [];

  final int exerciseId;
  final String name;
  final List<ExerciseSet> sets;

  void addSet(ExerciseSet set) {
    sets.add(set);
  }
}

class ExerciseSet extends IntervalEvent {
  ExerciseSet({
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
