import '../database/model/workout_record_entity.dart';
import '../database/workout_database.dart';
import '../model/workout.dart';
import 'workout_type_repository.dart';

class WorkoutRecordRepository {
  WorkoutRecordRepository(
    this.workoutTypeRepository,
  );

  final WorkoutTypeRepository workoutTypeRepository;

  Future<int> addWorkoutRecord(WorkoutType type) async {
    final workoutTypeId = workoutTypeRepository.getWorkoutTypeEntity(type).id;
    return await WorkoutDatabase.instance.workoutRecordDao.insert(
      WorkoutRecordEntity.create(workoutTypeId),
    );
  }
}
