import '../../database/model/workout_type_entity.dart';
import '../../model/workout.dart';

class WorkoutTypeFactory {
  static const _entityToTypeMap = {
    WorkoutTypeEntity.weightTraining: WorkoutType.weightTraining,
    WorkoutTypeEntity.running: WorkoutType.running,
  };

  static WorkoutType fromEntity(WorkoutTypeEntity entity) =>
      _entityToTypeMap[entity] ?? (throw Exception("$entity is not supported"));
}