import 'package:mockito/mockito.dart';
import 'package:workout_app/database/workout_database.dart';

import '../mock/composed_workout_dao.mocks.dart';
import '../mock/database.mocks.dart';
import '../mock/database_initializer.mocks.dart';
import '../mock/exercise_dao.mocks.dart';
import '../mock/exercise_set_dao.mocks.dart';
import '../mock/water_goal_dao.mocks.dart';
import '../mock/water_log_dao.mocks.dart';
import '../mock/workout_dao.mocks.dart';
import '../mock/workout_database.mocks.dart';
import '../mock/workout_detail_dao.mocks.dart';

class MockDB {
  static const mockDbPath = "dbPath";

  late MockDatabaseInitializer databaseInitializer;
  late MockDatabase database;
  late MockWorkoutDatabase workoutDatabase;
  late MockWorkoutDao workoutDao;
  late MockExerciseDao exerciseDao;
  late MockWorkoutDetailDao workoutDetailDao;
  late MockExerciseSetDao exerciseSetDao;
  late MockComposedWorkoutDao composedWorkoutDao;
  late MockWaterGoalDao waterGoalDao;
  late MockWaterLogDao waterLogDao;

  void setUp({
    bool deepMock = false,
  }) {
    if (deepMock) {
      _deepMock();
    } else {
      _shallowMock();
    }
  }

  void _shallowMock() {
    workoutDatabase = MockWorkoutDatabase();
    workoutDao = MockWorkoutDao();
    exerciseDao = MockExerciseDao();
    workoutDetailDao = MockWorkoutDetailDao();
    exerciseSetDao = MockExerciseSetDao();
    composedWorkoutDao = MockComposedWorkoutDao();
    waterGoalDao = MockWaterGoalDao();
    waterLogDao = MockWaterLogDao();

    when(workoutDatabase.dbPath).thenReturn(mockDbPath);
    when(workoutDatabase.workoutDao).thenReturn(workoutDao);
    when(workoutDatabase.exerciseDao).thenReturn(exerciseDao);
    when(workoutDatabase.workoutDetailDao).thenReturn(workoutDetailDao);
    when(workoutDatabase.exerciseSetDao).thenReturn(exerciseSetDao);
    when(workoutDatabase.composedWorkoutDao).thenReturn(composedWorkoutDao);
    when(workoutDatabase.waterGoalDao).thenReturn(waterGoalDao);
    when(workoutDatabase.waterLogDao).thenReturn(waterLogDao);

    WorkoutDatabase.setUpInstance(workoutDatabase);
  }

  void _deepMock() {
    databaseInitializer = MockDatabaseInitializer();
    database = MockDatabase();

    when(databaseInitializer.open()).thenAnswer((_) async => database);
    when(databaseInitializer.dbPath).thenReturn(mockDbPath);

    final workoutDatabase = WorkoutDatabase.instance;
    workoutDatabase.setUpDatabaseInitializer(databaseInitializer);
  }
}
