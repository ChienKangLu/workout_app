import '../schema.dart';
import 'base_entity.dart';

class WorkoutEntity extends BaseEntity {
  WorkoutEntity({
    required this.workoutId,
    required this.createDateTime,
    required this.startDateTime,
    required this.endDateTime,
  });

  WorkoutEntity.create({
    required int createDateTime,
    int? startDateTime,
    int? endDateTime,
  }) : this(
          workoutId: ignored,
          createDateTime: createDateTime,
          startDateTime: startDateTime,
          endDateTime: endDateTime,
        );

  WorkoutEntity.fromMap(Map<String, dynamic> map)
      : this(
          workoutId: map[WorkoutTable.columnWorkoutId],
          createDateTime: map[WorkoutTable.columnWorkoutCreateDateTime],
          startDateTime: map[WorkoutTable.columnWorkoutStartDateTime],
          endDateTime: map[WorkoutTable.columnWorkoutEndDateTime],
        );

  final int workoutId;
  final int createDateTime;
  final int? startDateTime;
  final int? endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (workoutId != ignored) {
      map[WorkoutTable.columnWorkoutId] = workoutId;
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
  List<Object?> get props =>
      [workoutId, createDateTime, startDateTime, endDateTime];
}
