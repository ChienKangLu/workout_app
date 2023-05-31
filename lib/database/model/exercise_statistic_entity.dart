import '../schema.dart';
import 'base_entity.dart';

class ExerciseStatisticEntity extends BaseEntity {
  static const columnMax = "max";

  ExerciseStatisticEntity({
    required this.name,
    required this.exerciseId,
    required this.max,
  });

  final String name;
  final int exerciseId;
  final double max;

  ExerciseStatisticEntity.fromMap(Map<String, dynamic> map)
      : this(
          name: map[ExerciseTable.columnExerciseName],
          exerciseId: map[WeightTrainingSetTable.columnExerciseId],
          max: map[columnMax],
        );

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[ExerciseTable.columnExerciseName] = name;
    map[WeightTrainingSetTable.columnExerciseId] = exerciseId;
    map[columnMax] = exerciseId;
    return map;
  }
}
