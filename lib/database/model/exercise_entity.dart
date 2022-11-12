import '../schema.dart';
import 'base_entity.dart';
import 'workout_type_entity.dart';

class ExerciseEntity extends BaseEntity {
  ExerciseEntity({
    required this.exerciseId,
    required this.workoutTypeEntity,
    required this.name,
  });

  ExerciseEntity.create({
    required WorkoutTypeEntity workoutType,
    required String name,
  }) : this(
          exerciseId: ignored,
          workoutTypeEntity: workoutType,
          name: name,
        );

  ExerciseEntity.fromMap(Map<String, dynamic> map)
      : this(
          exerciseId: map[ExerciseTable.columnExerciseId],
          workoutTypeEntity: WorkoutTypeEntity.fromId(map[ExerciseTable.columnWorkoutTypeId]),
          name: map[ExerciseTable.columnExerciseName],
        );

  final int exerciseId;
  final WorkoutTypeEntity workoutTypeEntity;
  final String name;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (exerciseId != ignored) {
      map[ExerciseTable.columnExerciseId] = exerciseId;
    }
    map[ExerciseTable.columnWorkoutTypeId] = workoutTypeEntity.id;
    map[ExerciseTable.columnExerciseName] = name;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseEntity &&
          runtimeType == other.runtimeType &&
          exerciseId == other.exerciseId &&
          workoutTypeEntity == other.workoutTypeEntity &&
          name == other.name;

  @override
  int get hashCode =>
      exerciseId.hashCode ^ workoutTypeEntity.hashCode ^ name.hashCode;
}
