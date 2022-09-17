import '../schema.dart';
import 'base_entity.dart';

class WorkoutRecordEntity extends BaseEntity{
  WorkoutRecordEntity(
    this.id,
    this.workoutTypeId,
    this.startDateTime,
    this.endDateTime,
  );

  WorkoutRecordEntity.create(this.workoutTypeId)
      : id = ignoredId,
        startDateTime = null,
        endDateTime = null;

  WorkoutRecordEntity.fromMap(Map<String, dynamic> map)
      : id = map[WorkoutRecordTable.columnWorkoutRecordId],
        workoutTypeId = map[WorkoutRecordTable.columnWorkoutTypeId],
        startDateTime = map[WorkoutRecordTable.columnStartDateTime],
        endDateTime = map[WorkoutRecordTable.columnEndDateTime];

  final int id;
  final int workoutTypeId;
  final int? startDateTime;
  final int? endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != ignoredId) {
      map[WorkoutRecordTable.columnWorkoutRecordId] = id;
    }
    map[WorkoutRecordTable.columnWorkoutTypeId] = workoutTypeId;
    if (startDateTime != null) {
      map[WorkoutRecordTable.columnStartDateTime] = startDateTime;
    }
    if (endDateTime != null) {
      map[WorkoutRecordTable.columnEndDateTime] = endDateTime;
    }
    return map;
  }
}
