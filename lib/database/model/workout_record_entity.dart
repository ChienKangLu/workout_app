import '../schema.dart';
import 'base_entity.dart';

class WorkoutRecordEntity extends BaseEntity {
  WorkoutRecordEntity({
    required this.workoutRecordId,
    required this.workoutTypeId,
    required this.workoutTypeIndex,
    required this.startDateTime,
    required this.endDateTime,
  });

  WorkoutRecordEntity.create({
    required this.workoutTypeId,
    this.startDateTime,
    this.endDateTime,
  })  : workoutRecordId = ignored,
        workoutTypeIndex = ignored;

  WorkoutRecordEntity.fromMap(Map<String, dynamic> map)
      : workoutRecordId = map[WorkoutRecordTable.columnWorkoutRecordId],
        workoutTypeId = map[WorkoutRecordTable.columnWorkoutTypeId],
        workoutTypeIndex = map[WorkoutRecordTable.columnWorkoutTypeIndex],
        startDateTime = map[WorkoutRecordTable.columnStartDateTime],
        endDateTime = map[WorkoutRecordTable.columnEndDateTime];

  final int workoutRecordId;
  final int workoutTypeId;
  final int workoutTypeIndex;
  final int? startDateTime;
  final int? endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (workoutRecordId != ignored) {
      map[WorkoutRecordTable.columnWorkoutRecordId] = workoutRecordId;
    }
    map[WorkoutRecordTable.columnWorkoutTypeId] = workoutTypeId;
    if (workoutTypeIndex != ignored) {
      map[WorkoutRecordTable.columnWorkoutTypeIndex] = workoutTypeIndex;
    }
    if (startDateTime != null) {
      map[WorkoutRecordTable.columnStartDateTime] = startDateTime;
    }
    if (endDateTime != null) {
      map[WorkoutRecordTable.columnEndDateTime] = endDateTime;
    }
    return map;
  }
}
