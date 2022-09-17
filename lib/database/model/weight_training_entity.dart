import '../schema.dart';
import 'base_workout_entity.dart';

class WeightTrainingEntity extends BaseWorkoutEntity {
  WeightTrainingEntity(
    super.workoutRecordId,
    super.exerciseTypeId,
    super.setNum,
    this.baseWeight,
    this.sideWeight,
    this.repetition,
    this.dateTime,
  );

  WeightTrainingEntity.fromMap(Map<String, dynamic> map)
      : baseWeight = map[WeightTrainingTable.columnBaseWeight],
        sideWeight = map[WeightTrainingTable.columnSideWeight],
        repetition = map[WeightTrainingTable.columnRepetition],
        dateTime = map[WeightTrainingTable.columnEndDateTime],
        super(
          map[RunningTable.columnWorkoutRecordId],
          map[RunningTable.columnExerciseId],
          map[RunningTable.columnSetNum],
        );

  final double baseWeight;
  final double sideWeight;
  final int repetition;
  final int dateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[WeightTrainingTable.columnWorkoutRecordId] = workoutRecordId;
    map[WeightTrainingTable.columnExerciseId] = exerciseTypeId;
    map[WeightTrainingTable.columnSetNum] = setNum;
    map[WeightTrainingTable.columnBaseWeight] = baseWeight;
    map[WeightTrainingTable.columnSideWeight] = sideWeight;
    map[WeightTrainingTable.columnRepetition] = repetition;
    map[WeightTrainingTable.columnEndDateTime] = dateTime;
    return map;
  }
}
