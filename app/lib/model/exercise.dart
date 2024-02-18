import 'interval_event.dart';
import 'unit.dart';

// ignore: must_be_immutable
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

  @override
  List<Object?> get props => super.props..addAll([exerciseId, name, sets]);
}

// ignore: must_be_immutable
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

  double totalWeight() => baseWeight + sideWeight * 2;

  @override
  List<Object?> get props => super.props
    ..addAll([
      baseWeight,
      sideWeight,
      unit,
      repetition,
    ]);
}
