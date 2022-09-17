import '../schema.dart';
import 'base_entity.dart';

class ExerciseEntity extends BaseEntity {
  ExerciseEntity(
    this.id,
    this.workoutTypeId,
    this.name,
  );

  ExerciseEntity.create(
    this.name,
    this.workoutTypeId,
  ) : id = ignoredId;

  ExerciseEntity.fromMap(Map<String, dynamic> map)
      : id = map[ExerciseTable.columnExerciseId],
        workoutTypeId = map[ExerciseTable.columnWorkoutTypeId],
        name = map[ExerciseTable.columnExerciseName];

  final int id;
  final int workoutTypeId;
  final String name;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != ignoredId) {
      map[ExerciseTable.columnExerciseId] = id;
    }
    map[ExerciseTable.columnWorkoutTypeId] = workoutTypeId;
    map[ExerciseTable.columnExerciseName] = name;
    return map;
  }
}
