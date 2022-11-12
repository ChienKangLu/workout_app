import '../schema.dart';
import 'base_entity.dart';

class WorkoutDetailEntity extends BaseEntity {
  WorkoutDetailEntity({
    required this.workoutId,
    required this.exerciseId,
    required this.createDateTime,
  });

  WorkoutDetailEntity.fromMap(Map<String, dynamic> map)
      : this(
          workoutId: map[WorkoutDetailTable.columnWorkoutId],
          exerciseId: map[WorkoutDetailTable.columnExerciseId],
          createDateTime: map[WorkoutDetailTable.columnExerciseCreateDateTime],
        );

  final int workoutId;
  final int exerciseId;
  final int createDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[WorkoutDetailTable.columnWorkoutId] = workoutId;
    map[WorkoutDetailTable.columnExerciseId] = exerciseId;
    map[WorkoutDetailTable.columnExerciseCreateDateTime] = createDateTime;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutDetailEntity &&
          runtimeType == other.runtimeType &&
          workoutId == other.workoutId &&
          exerciseId == other.exerciseId &&
          createDateTime == other.createDateTime;

  @override
  int get hashCode =>
      workoutId.hashCode ^ exerciseId.hashCode ^ createDateTime.hashCode;
}
