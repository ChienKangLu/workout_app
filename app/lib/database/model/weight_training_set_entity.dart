import '../schema.dart';
import 'exercise_set_entity.dart';

class WeightTrainingSetEntity extends ExerciseSetEntity {
  WeightTrainingSetEntity({
    required super.workoutId,
    required super.exerciseId,
    required super.setNum,
    required this.baseWeight,
    required this.sideWeight,
    required this.repetition,
    required this.endDateTime,
  });

  WeightTrainingSetEntity.create({
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

  WeightTrainingSetEntity.update({
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

  WeightTrainingSetEntity.fromMap(Map<String, dynamic> map)
      : this(
          workoutId: map[RunningSetTable.columnWorkoutId],
          exerciseId: map[RunningSetTable.columnExerciseId],
          setNum: map[RunningSetTable.columnSetNum],
          baseWeight: map[WeightTrainingSetTable.columnBaseWeight],
          sideWeight: map[WeightTrainingSetTable.columnSideWeight],
          repetition: map[WeightTrainingSetTable.columnRepetition],
          endDateTime: map[WeightTrainingSetTable.columnSetEndDateTime],
        );

  final double baseWeight;
  final double sideWeight;
  final int repetition;
  final int endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[WeightTrainingSetTable.columnWorkoutId] = workoutId;
    map[WeightTrainingSetTable.columnExerciseId] = exerciseId;
    map[WeightTrainingSetTable.columnSetNum] = setNum;
    map[WeightTrainingSetTable.columnBaseWeight] = baseWeight;
    map[WeightTrainingSetTable.columnSideWeight] = sideWeight;
    map[WeightTrainingSetTable.columnRepetition] = repetition;
    if (endDateTime != ignored) {
      map[WeightTrainingSetTable.columnSetEndDateTime] = endDateTime;
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WeightTrainingSetEntity &&
          runtimeType == other.runtimeType &&
          baseWeight == other.baseWeight &&
          sideWeight == other.sideWeight &&
          repetition == other.repetition &&
          endDateTime == other.endDateTime;

  @override
  int get hashCode =>
      super.hashCode ^
      baseWeight.hashCode ^
      sideWeight.hashCode ^
      repetition.hashCode ^
      endDateTime.hashCode;
}