import 'exercise.dart';
import 'interval_event.dart';

enum WorkoutType {
  weightTraining,
  running;
}

abstract class Workout<T extends Exercise> extends IntervalEvent {
  Workout({
    required this.workoutId,
    required this.type,
    required this.typeNum,
    required this.createDateTime,
    List<T>? exercises,
  }) : exercises = exercises ?? [];

  final int workoutId;
  final WorkoutType type;
  final int typeNum;
  final DateTime createDateTime;
  final List<T> exercises;

  void addExercise(T exercise) {
    exercises.add(exercise);
  }
}

class WeightTraining extends Workout<WeightTrainingExercise> {
  WeightTraining({
    required super.workoutId,
    required super.typeNum,
    required super.createDateTime,
    List<WeightTrainingExercise>? exercises,
  }) : super(
          type: WorkoutType.weightTraining,
          exercises: exercises,
        );
}

class Running extends Workout<RunningExercise> {
  Running({
    required super.workoutId,
    List<RunningExercise>? exercises,
    required super.typeNum,
    required super.createDateTime,
  }) : super(
          type: WorkoutType.running,
          exercises: exercises,
        );
}
