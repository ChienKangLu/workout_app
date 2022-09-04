import '../schema.dart';

class RecordEntity {
  RecordEntity(this.id, this.workoutId, this.startTime, this.endTime);

  RecordEntity.create(this.workoutId)
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
      map[RecordTable.columnId] = id;
    }
    map[RecordTable.columnWorkoutId] = workoutId;
    if (startTime != null) {
      map[RecordTable.columnStartDateTime] = startTime;
    }
    if (endTime != null) {
      map[RecordTable.columnEndDateTime] = endTime;
    }
    return map;
  }

  RecordEntity.fromMap(Map<String, dynamic> map)
      : id = map[RecordTable.columnId],
        workoutId = map[RecordTable.columnWorkoutId],
        startTime = map[RecordTable.columnStartDateTime],
        endTime = map[RecordTable.columnEndDateTime];

  @override
  String toString() {
    return "RecordEntity{id: $id, workoutId: $workoutId, startTime: $startTime, endTime: $endTime}";
  }
}
