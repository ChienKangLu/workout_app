import 'Exercise.dart';

class Workout {
  Workout({required this.name, required this.exercises});

  final String name;

  final List<Exercise> exercises;
}