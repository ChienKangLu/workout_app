import '../database/model/workout_record_entity.dart';
import '../database/model/workout_type_entity.dart';
import '../database/workout_database.dart';
import '../model/workout.dart';

class WorkoutRepository {
  Future<List<WorkoutType>> get workoutTypes async =>
      WorkoutTypeEntity.values.map((entity) {
        switch (entity) {
          case WorkoutTypeEntity.weightTraining:
            return WorkoutType.weightTraining;
          case WorkoutTypeEntity.running:
            return WorkoutType.running;
        }
      }).toList(growable: false);

  Future<int> createWorkout(WorkoutType type) async {
    final workoutTypeId = _getWorkoutTypeEntity(type).id;
    return await WorkoutDatabase.instance.workoutRecordDao.insert(
      WorkoutRecordEntity.create(workoutTypeId),
    );
  }

  WorkoutTypeEntity _getWorkoutTypeEntity(WorkoutType type) {
    switch (type) {
      case WorkoutType.weightTraining:
        return WorkoutTypeEntity.weightTraining;
      case WorkoutType.running:
        return WorkoutTypeEntity.running;
    }
  }
}
