import 'exercise.dart';
import 'interval_event.dart';

enum WorkoutType {
  weightTraining,
  running;
}

abstract class Workout<T extends Exercise> extends IntervalEvent {
  Workout({
    required this.name,
    required this.type,
    List<T>? exercises,
  }) : exercises = exercises ?? [];

  final String name;
  final WorkoutType type;
  final List<T> exercises;

  void addExercise(T exercise) {
    exercises.add(exercise);
  }
}

class WeightTraining extends Workout<WeightTrainingExercise> {
  WeightTraining({
    required super.name,
    List<WeightTrainingExercise>? exercises,
  }) : super(type: WorkoutType.weightTraining, exercises: exercises);
}

class Running extends Workout<RunningExercise> {
  Running({
    required super.name,
    List<RunningExercise>? exercises,
  }) : super(type: WorkoutType.running, exercises: exercises);
}
