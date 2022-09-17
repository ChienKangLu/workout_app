import '../schema.dart';
import 'base_workout_entity.dart';

class RunningEntity extends BaseWorkoutEntity {
  RunningEntity(
    super.workoutRecordId,
    super.exerciseTypeId,
    super.setNum,
    this.duration,
    this.distance,
  );

  RunningEntity.fromMap(Map<String, dynamic> map)
      : duration = map[RunningTable.columnDuration],
        distance = map[RunningTable.columnDistance],
        super(
          map[RunningTable.columnWorkoutRecordId],
          map[RunningTable.columnExerciseId],
          map[RunningTable.columnSetNum],
        );

  final double duration;
  final double distance;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[RunningTable.columnWorkoutRecordId] = workoutRecordId;
    map[RunningTable.columnExerciseId] = exerciseTypeId;
    map[RunningTable.columnSetNum] = setNum;
    map[RunningTable.columnDuration] = duration;
    map[RunningTable.columnDistance] = distance;
    return map;
  }
}
