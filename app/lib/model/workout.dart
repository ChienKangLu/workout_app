import 'exercise.dart';
import 'interval_event.dart';

class Workout extends IntervalEvent {
  Workout({
    required this.workoutId,
    required this.createDateTime,
    List<Exercise>? exercises,
  }) : exercises = exercises ?? [];

  final int workoutId;
  final DateTime createDateTime;
  final List<Exercise> exercises;

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
  }
}
