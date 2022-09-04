import '../database/model/record_entity.dart';
import '../database/workout_database.dart';
import '../model/workout.dart';

class RecordRepository {
  Future<int> addRecord(WorkoutType type) async {
    return await WorkoutDatabase.instance.recordDao.insert(
      RecordEntity.create(type.id),
    );
  }
}
