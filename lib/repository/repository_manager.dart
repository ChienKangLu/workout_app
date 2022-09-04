import 'record_repository.dart';
import 'workout_type_repository.dart';

class RepositoryManager {
  static RepositoryManager? _instance;
  static WorkoutTypeRepository? _workoutTypeRepository;
  static RecordRepository? _recordRepository;

  RepositoryManager._();

  static RepositoryManager get instance => _instance ??= RepositoryManager._();

  WorkoutTypeRepository get workoutRepository =>
      _workoutTypeRepository ?? WorkoutTypeRepository();

  RecordRepository get recordRepository =>
      _recordRepository ?? RecordRepository();
}
