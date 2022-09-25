import 'package:sqflite/sqflite.dart';

import 'dao/exercise_dao.dart';
import 'dao/running_dao.dart';
import 'dao/weight_training_dao.dart';
import 'dao/workout_record_dao.dart';
import 'database_initializer.dart';
import 'mockup/mock_data_initializer.dart';

class WorkoutDatabase {
  static const isMockupEnabled = true;

  WorkoutDatabase._();
  static final WorkoutDatabase instance = WorkoutDatabase._();

  final workoutRecordDao = WorkoutRecordDao();
  final exerciseDao = ExerciseDao();
  final weightTrainingDao = WeightTrainingDao();
  final runningDao = RunningDao();

  late final _initializer = DatabaseInitializer();
  late final _mockDataInitializer = MockDataInitializer();

  static Database? _databaseInstance;
  Future<Database> get _database async {
    _databaseInstance ??= await _initializer.open();
    return _databaseInstance!;
  }

  Future<void> init() async {
    await _database;

    await workoutRecordDao.init(_database);
    await exerciseDao.init(_database);
    await weightTrainingDao.init(_database);
    await runningDao.init(_database);

    if (_initializer.isFirstCreation && isMockupEnabled) {
      await _mockDataInitializer.initTestData();
    }
  }
}
