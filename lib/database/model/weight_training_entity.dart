import '../schema.dart';
import 'base_workout_entity.dart';

class WeightTrainingEntity extends WorkoutEntity {
  WeightTrainingEntity({
    required super.workoutRecordId,
    required super.exerciseTypeId,
    required super.setNum,
    required this.baseWeight,
    required this.sideWeight,
    required this.repetition,
    required this.endDateTime,
  });

  WeightTrainingEntity.fromMap(Map<String, dynamic> map)
      : baseWeight = map[WeightTrainingTable.columnBaseWeight],
        sideWeight = map[WeightTrainingTable.columnSideWeight],
        repetition = map[WeightTrainingTable.columnRepetition],
        endDateTime = map[WeightTrainingTable.columnEndDateTime],
        super(
          workoutRecordId: map[RunningTable.columnWorkoutRecordId],
          exerciseTypeId: map[RunningTable.columnExerciseTypeId],
          setNum: map[RunningTable.columnSetNum],
        );

  final double baseWeight;
  final double sideWeight;
  final int repetition;
  final int endDateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[WeightTrainingTable.columnWorkoutRecordId] = workoutRecordId;
    map[WeightTrainingTable.columnExerciseTypeId] = exerciseTypeId;
    map[WeightTrainingTable.columnSetNum] = setNum;
    map[WeightTrainingTable.columnBaseWeight] = baseWeight;
    map[WeightTrainingTable.columnSideWeight] = sideWeight;
    map[WeightTrainingTable.columnRepetition] = repetition;
    map[WeightTrainingTable.columnEndDateTime] = endDateTime;
    return map;
  }
}
