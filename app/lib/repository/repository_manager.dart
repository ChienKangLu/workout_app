import 'exercise_repository.dart';
import 'workout_repository.dart';

class RepositoryManager {
  static RepositoryManager? _instance;
  static WorkoutRepository? _workoutRepository;
  static ExerciseRepository? _exerciseRepository;

  RepositoryManager._();

  static RepositoryManager get instance => _instance ??= RepositoryManager._();

  WorkoutRepository get workoutRepository =>
      _workoutRepository ??= WorkoutRepository();
  ExerciseRepository get exerciseRepository =>
      _exerciseRepository ??= ExerciseRepository();
}
