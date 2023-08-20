import 'database_repository.dart';
import 'exercise_repository.dart';
import 'google_repository.dart';
import 'water_repository.dart';
import 'workout_repository.dart';

class RepositoryManager {
  static RepositoryManager? _instance;
  static WorkoutRepository? _workoutRepository;
  static ExerciseRepository? _exerciseRepository;
  static WaterRepository? _waterRepository;
  static GoogleRepository? _googleRepository;
  static DatabaseRepository? _databaseRepository;

  RepositoryManager._();

  static RepositoryManager get instance => _instance ??= RepositoryManager._();

  WorkoutRepository get workoutRepository =>
      _workoutRepository ??= WorkoutRepository();
  ExerciseRepository get exerciseRepository =>
      _exerciseRepository ??= ExerciseRepository();
  WaterRepository get waterRepository => _waterRepository ??= WaterRepository();
  GoogleRepository get googleRepository =>
      _googleRepository ??= GoogleRepository();
  DatabaseRepository get databaseRepository =>
      _databaseRepository ??= DatabaseRepository();
}
