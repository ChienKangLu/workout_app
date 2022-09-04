import '../schema.dart';

class WorkoutRecordEntity {
  WorkoutRecordEntity(this.id, this.workoutId, this.startTime, this.endTime);

  WorkoutRecordEntity.create(this.workoutId)
      : id = ignoredId,
        startTime = null,
        endTime = null;

  final int id;
  final int workoutId;
  final int? startTime;
  final int? endTime;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != ignoredId) {
      map[WorkoutRecordTable.columnId] = id;
    }
    map[WorkoutRecordTable.columnWorkoutTypeId] = workoutId;
    if (startTime != null) {
      map[WorkoutRecordTable.columnStartDateTime] = startTime;
    }
    if (endTime != null) {
      map[WorkoutRecordTable.columnEndDateTime] = endTime;
    }
    return map;
  }

  WorkoutRecordEntity.fromMap(Map<String, dynamic> map)
      : id = map[WorkoutRecordTable.columnId],
        workoutId = map[WorkoutRecordTable.columnWorkoutTypeId],
        startTime = map[WorkoutRecordTable.columnStartDateTime],
        endTime = map[WorkoutRecordTable.columnEndDateTime];

  @override
  String toString() {
    return "WorkoutRecordEntity{id: $id, workoutId: $workoutId, startTime: $startTime, endTime: $endTime}";
  }
}
