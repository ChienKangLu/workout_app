import '../schema.dart';
import 'exercise_set_entity.dart';

class RunningSetEntity extends ExerciseSetEntity {
  RunningSetEntity({
    required super.workoutId,
    required super.exerciseId,
    required super.setNum,
    required this.duration,
    required this.distance,
    required this.endDateTime,
  });

  RunningSetEntity.fromMap(Map<String, dynamic> map)
      : this(
          workoutId: map[RunningSetTable.columnWorkoutId],
          exerciseId: map[RunningSetTable.columnExerciseId],
          setNum: map[RunningSetTable.columnSetNum],
          duration: map[RunningSetTable.columnDuration],
          distance: map[RunningSetTable.columnDistance],
          endDateTime: map[RunningSetTable.columnSetEndDateTime],
        );

  final double duration;
  final double distance;
  final int endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[RunningSetTable.columnWorkoutId] = workoutId;
    map[RunningSetTable.columnExerciseId] = exerciseId;
    map[RunningSetTable.columnSetNum] = setNum;
    map[RunningSetTable.columnDuration] = duration;
    map[RunningSetTable.columnDistance] = distance;
    map[RunningSetTable.columnSetEndDateTime] = endDateTime;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is RunningSetEntity &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          distance == other.distance &&
          endDateTime == other.endDateTime;

  @override
  int get hashCode =>
      super.hashCode ^
      duration.hashCode ^
      distance.hashCode ^
      endDateTime.hashCode;
}
