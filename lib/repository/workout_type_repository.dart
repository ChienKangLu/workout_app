import '../database/workout_database.dart';
import '../model/workout.dart';

class WorkoutTypeRepository {
  Future<List<WorkoutType>> get workoutTypes async {
    final entities = await WorkoutDatabase.instance.workoutDao.getAll();
    return entities.map((entity) => WorkoutType.fromId(entity.id)).toList();
  }
}
