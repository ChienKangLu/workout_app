import '../schema.dart';
import 'base_entity.dart';

class ExerciseEntity extends BaseEntity {
  ExerciseEntity({
    required this.exerciseTypeId,
    required this.workoutTypeId,
    required this.name,
  });

  ExerciseEntity.create({
    required this.name,
    required this.workoutTypeId,
  }) : exerciseTypeId = ignored;

  ExerciseEntity.fromMap(Map<String, dynamic> map)
      : exerciseTypeId = map[ExerciseTable.columnExerciseTypeId],
        workoutTypeId = map[ExerciseTable.columnWorkoutTypeId],
        name = map[ExerciseTable.columnExerciseName];

  final int exerciseTypeId;
  final int workoutTypeId;
  final String name;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (exerciseTypeId != ignored) {
      map[ExerciseTable.columnExerciseTypeId] = exerciseTypeId;
    }
    map[ExerciseTable.columnWorkoutTypeId] = workoutTypeId;
    map[ExerciseTable.columnExerciseName] = name;
    return map;
  }
}
