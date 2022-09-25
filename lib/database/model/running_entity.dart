import '../schema.dart';
import 'base_workout_entity.dart';

class RunningEntity extends WorkoutEntity {
  RunningEntity({
    required super.workoutRecordId,
    required super.exerciseTypeId,
    required super.setNum,
    required this.duration,
    required this.distance,
    required this.endDateTime,
  });

  RunningEntity.fromMap(Map<String, dynamic> map)
      : duration = map[RunningTable.columnDuration],
        distance = map[RunningTable.columnDistance],
        endDateTime = map[RunningTable.columnEndDateTime],
        super(
          workoutRecordId: map[RunningTable.columnWorkoutRecordId],
          exerciseTypeId: map[RunningTable.columnExerciseTypeId],
          setNum: map[RunningTable.columnSetNum],
        );

  final double duration;
  final double distance;
  final int endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[RunningTable.columnWorkoutRecordId] = workoutRecordId;
    map[RunningTable.columnExerciseTypeId] = exerciseTypeId;
    map[RunningTable.columnSetNum] = setNum;
    map[RunningTable.columnDuration] = duration;
    map[RunningTable.columnDistance] = distance;
    map[RunningTable.columnEndDateTime] = endDateTime;
    return map;
  }
}
