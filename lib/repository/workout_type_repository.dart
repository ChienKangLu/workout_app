import '../database/model/workout_type_entity.dart';
import '../model/workout.dart';

class WorkoutTypeRepository {
  Future<List<WorkoutType>> get workoutTypes async =>
      WorkoutTypeEntity.values.map((entity) {
        switch (entity) {
          case WorkoutTypeEntity.weightTraining:
            return WorkoutType.weightTraining;
          case WorkoutTypeEntity.running:
            return WorkoutType.running;
        }
      }).toList(growable: false);

  WorkoutTypeEntity getWorkoutTypeEntity(WorkoutType type) {
    switch (type) {
      case WorkoutType.weightTraining:
        return WorkoutTypeEntity.weightTraining;
      case WorkoutType.running:
        return WorkoutTypeEntity.running;
    }
  }
}
