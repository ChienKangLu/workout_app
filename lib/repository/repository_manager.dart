import 'workout_repository.dart';

class RepositoryManager {
  static RepositoryManager? _instance;
  static WorkoutRepository? _workoutRepository;

  RepositoryManager._();

  static RepositoryManager get instance => _instance ??= RepositoryManager._();

  WorkoutRepository get workoutRepository =>
      _workoutRepository ?? WorkoutRepository();
}
