import '../schema.dart';
import 'base_entity.dart';

class ExerciseEntity extends BaseEntity {
  ExerciseEntity({
    required this.exerciseId,
    required this.name,
  });

  ExerciseEntity.create({
    required String name,
  }) : this(
          exerciseId: ignored,
          name: name,
        );

  ExerciseEntity.update({
    required int exerciseId,
    required String name,
  }) : this(
          exerciseId: exerciseId,
          name: name,
        );

  ExerciseEntity.fromMap(Map<String, dynamic> map)
      : this(
          exerciseId: map[ExerciseTable.columnExerciseId],
          name: map[ExerciseTable.columnExerciseName],
        );

  final int exerciseId;
  final String name;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (exerciseId != ignored) {
      map[ExerciseTable.columnExerciseId] = exerciseId;
    }
    map[ExerciseTable.columnExerciseName] = name;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseEntity &&
          runtimeType == other.runtimeType &&
          exerciseId == other.exerciseId &&
          name == other.name;

  @override
  int get hashCode => exerciseId.hashCode ^ name.hashCode;
}
