import 'exercise.dart';
import 'interval_event.dart';

enum WorkoutType {
  weightTraining,
  running;
}

abstract class Workout<T extends Exercise> extends IntervalEvent {
  Workout({
    required this.workoutRecordId,
    required this.type,
    required this.index,
    required this.createDateTime,
    List<T>? exercises,
  }) : exercises = exercises ?? [];

  final int workoutRecordId;
  final WorkoutType type;
  final int index;
  final DateTime createDateTime;
  final List<T> exercises;

  void addExercise(T exercise) {
    exercises.add(exercise);
  }
}

class WeightTraining extends Workout<WeightTrainingExercise> {
  WeightTraining({
    required super.workoutRecordId,
    required super.index,
    required super.createDateTime,
    List<WeightTrainingExercise>? exercises,
  }) : super(
          type: WorkoutType.weightTraining,
          exercises: exercises,
        );
}

class Running extends Workout<RunningExercise> {
  Running({
    required super.workoutRecordId,
    List<RunningExercise>? exercises,
    required super.index,
    required super.createDateTime,
  }) : super(
          type: WorkoutType.running,
          exercises: exercises,
        );
}
