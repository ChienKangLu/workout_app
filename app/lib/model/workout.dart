import 'exercise.dart';
import 'interval_event.dart';

// ignore: must_be_immutable
class Workout extends IntervalEvent {
  Workout({
    required this.workoutId,
    required this.createDateTime,
    List<Exercise>? exercises,
    super.startDateTime,
    super.endDateTime,
  }) : exercises = exercises ?? [];

  final int workoutId;
  final DateTime createDateTime;
  final List<Exercise> exercises;

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
  }

  @override
  List<Object?> get props => super.props
    ..addAll([
      workoutId,
      createDateTime.millisecondsSinceEpoch,
      exercises,
    ]);
}
