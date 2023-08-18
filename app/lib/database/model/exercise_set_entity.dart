import '../schema.dart';
import 'base_entity.dart';

class ExerciseSetEntity extends BaseEntity {
  ExerciseSetEntity({
    required this.workoutId,
    required this.exerciseId,
    required this.setNum,
    required this.baseWeight,
    required this.sideWeight,
    required this.repetition,
    required this.endDateTime,
  });

  ExerciseSetEntity.create({
    required int workoutId,
    required int exerciseId,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
    required int endDateTime,
  }) : this(
          workoutId: workoutId,
          exerciseId: exerciseId,
          setNum: ignored,
          baseWeight: baseWeight,
          sideWeight: sideWeight,
          repetition: repetition,
          endDateTime: endDateTime,
        );

  ExerciseSetEntity.update({
    required int workoutId,
    required int exerciseId,
    required int setNum,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) : this(
          workoutId: workoutId,
          exerciseId: exerciseId,
          setNum: setNum,
          baseWeight: baseWeight,
          sideWeight: sideWeight,
          repetition: repetition,
          endDateTime: ignored,
        );

  ExerciseSetEntity.fromMap(Map<String, dynamic> map)
      : this(
          workoutId: map[ExerciseSetTable.columnWorkoutId],
          exerciseId: map[ExerciseSetTable.columnExerciseId],
          setNum: map[ExerciseSetTable.columnSetNum],
          baseWeight: map[ExerciseSetTable.columnBaseWeight],
          sideWeight: map[ExerciseSetTable.columnSideWeight],
          repetition: map[ExerciseSetTable.columnRepetition],
          endDateTime: map[ExerciseSetTable.columnSetEndDateTime],
        );

  final int workoutId;
  final int exerciseId;
  final int setNum;
  final double baseWeight;
  final double sideWeight;
  final int repetition;
  final int endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[ExerciseSetTable.columnWorkoutId] = workoutId;
    map[ExerciseSetTable.columnExerciseId] = exerciseId;
    map[ExerciseSetTable.columnSetNum] = setNum;
    map[ExerciseSetTable.columnBaseWeight] = baseWeight;
    map[ExerciseSetTable.columnSideWeight] = sideWeight;
    map[ExerciseSetTable.columnRepetition] = repetition;
    if (endDateTime != ignored) {
      map[ExerciseSetTable.columnSetEndDateTime] = endDateTime;
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ExerciseSetEntity &&
          runtimeType == other.runtimeType &&
          workoutId == other.workoutId &&
          exerciseId == other.exerciseId &&
          setNum == other.setNum &&
          baseWeight == other.baseWeight &&
          sideWeight == other.sideWeight &&
          repetition == other.repetition &&
          endDateTime == other.endDateTime;

  @override
  int get hashCode =>
      super.hashCode ^
      workoutId.hashCode ^
      exerciseId.hashCode ^
      setNum.hashCode ^
      baseWeight.hashCode ^
      sideWeight.hashCode ^
      repetition.hashCode ^
      endDateTime.hashCode;
}
