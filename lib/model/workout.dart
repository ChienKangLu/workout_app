import 'exercise.dart';
import 'interval_event.dart';

enum WorkoutType {
  weightTraining(_weightTrainingId),
  running(_runningId);

  static const int _weightTrainingId = 1;
  static const int _runningId = 2;

  const WorkoutType(this.id);

  final int id;

  static WorkoutType fromId(int id) {
    return values.firstWhere(
      (type) => type.id == id,
      orElse: () => throw Exception("id is not supported"),
    );
  }
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
