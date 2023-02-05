import 'package:sqflite/sqflite.dart';

import 'dao/composed_workout_dao.dart';
import 'dao/exercise_dao.dart';
import 'dao/running_set_dao.dart';
import 'dao/weight_training_set_dao.dart';
import 'dao/workout_dao.dart';
import 'dao/workout_detail_dao.dart';
import 'database_initializer.dart';
import 'mockup/mock_data_initializer.dart';

class WorkoutDatabase {
  static const isMockupEnabled = false;

  WorkoutDatabase._();
  static final WorkoutDatabase instance = WorkoutDatabase._();

  final workoutDao = WorkoutDao();
  final exerciseDao = ExerciseDao();
  final workoutDetailDao = WorkoutDetailDao();
  final weightTrainingSetDao = WeightTrainingSetDao();
  final runningSetDao = RunningSetDao();
  final composedWorkoutDao = ComposedWorkoutDao();

  late final _initializer = DatabaseInitializer();
  late final _mockDataInitializer = MockDataInitializer();

  static Database? _databaseInstance;
  Future<Database> get _database async {
    _databaseInstance ??= await _initializer.open();
    return _databaseInstance!;
  }

  Future<void> init() async {
    await _database;

    await workoutDao.init(_database);
    await exerciseDao.init(_database);
    await workoutDetailDao.init(_database);
    await weightTrainingSetDao.init(_database);
    await runningSetDao.init(_database);
    await composedWorkoutDao.init(_database);

    if (_initializer.isFirstCreation && isMockupEnabled) {
      await _mockDataInitializer.initTestData();
    }
  }
}
