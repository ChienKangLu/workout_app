import '../database/model/workout_record_entity.dart';
import '../database/workout_database.dart';
import '../model/workout.dart';

class WorkoutRecordRepository {
  Future<int> addWorkoutRecord(WorkoutType type) async {
    return await WorkoutDatabase.instance.workoutRecordDao.insert(
      WorkoutRecordEntity.create(type.id),
    );
  }
}
