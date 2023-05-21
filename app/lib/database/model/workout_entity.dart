import '../schema.dart';
import 'base_entity.dart';
import 'workout_type_entity.dart';

class WorkoutEntity extends BaseEntity {
  WorkoutEntity({
    required this.workoutId,
    required this.workoutTypeEntity,
    required this.workoutTypeNum,
    required this.createDateTime,
    required this.startDateTime,
    required this.endDateTime,
  });

  WorkoutEntity.create({
    required WorkoutTypeEntity workoutTypeEntity,
    required int createDateTime,
    int? startDateTime,
    int? endDateTime,
  }) : this(
          workoutId: ignored,
          workoutTypeEntity: workoutTypeEntity,
          workoutTypeNum: ignored,
          createDateTime: createDateTime,
          startDateTime: startDateTime,
          endDateTime: endDateTime,
        );

  WorkoutEntity.fromMap(Map<String, dynamic> map)
      : this(
          workoutId: map[WorkoutTable.columnWorkoutId],
          workoutTypeEntity: WorkoutTypeEntity.fromId(map[WorkoutTable.columnWorkoutTypeId]),
          workoutTypeNum: map[WorkoutTable.columnWorkoutTypeNum],
          createDateTime: map[WorkoutTable.columnWorkoutCreateDateTime],
          startDateTime: map[WorkoutTable.columnWorkoutStartDateTime],
          endDateTime: map[WorkoutTable.columnWorkoutEndDateTime],
        );

  final int workoutId;
  final WorkoutTypeEntity workoutTypeEntity;
  final int workoutTypeNum;
  final int createDateTime;
  final int? startDateTime;
  final int? endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (workoutId != ignored) {
      map[WorkoutTable.columnWorkoutId] = workoutId;
    }
    map[WorkoutTable.columnWorkoutTypeId] = workoutTypeEntity.id;
    if (workoutTypeNum != ignored) {
      map[WorkoutTable.columnWorkoutTypeNum] = workoutTypeNum;
    }
    map[WorkoutTable.columnWorkoutCreateDateTime] = createDateTime;
    if (startDateTime != null) {
      map[WorkoutTable.columnWorkoutStartDateTime] = startDateTime;
    }
    if (endDateTime != null) {
      map[WorkoutTable.columnWorkoutEndDateTime] = endDateTime;
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutEntity &&
          runtimeType == other.runtimeType &&
          workoutId == other.workoutId &&
          workoutTypeEntity == other.workoutTypeEntity &&
          workoutTypeNum == other.workoutTypeNum &&
          createDateTime == other.createDateTime &&
          startDateTime == other.startDateTime &&
          endDateTime == other.endDateTime;

  @override
  int get hashCode =>
      workoutId.hashCode ^
      workoutTypeEntity.hashCode ^
      workoutTypeNum.hashCode ^
      createDateTime.hashCode ^
      startDateTime.hashCode ^
      endDateTime.hashCode;
}
