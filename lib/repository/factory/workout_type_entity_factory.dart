import '../../database/model/workout_type_entity.dart';
import '../../model/workout.dart';

class WorkoutTypeEntityFactory {
  static const _typToEntityMap = {
    WorkoutType.weightTraining: WorkoutTypeEntity.weightTraining,
    WorkoutType.running: WorkoutTypeEntity.running,
  };

  static WorkoutTypeEntity fromType(WorkoutType type) =>
      _typToEntityMap[type] ?? (throw Exception("$type is not supported"));
}