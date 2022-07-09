import 'exercise_item.dart';

class WorkoutItem {
  WorkoutItem({required this.name, required this.exerciseItems});

  final String name;
  final List<ExerciseItem> exerciseItems;
}