import 'dart:io';

import 'package:sqflite/sqflite.dart';

import 'dao/composed_workout_dao.dart';
import 'dao/exercise_dao.dart';
import 'dao/water_goal_dao.dart';
import 'dao/water_log_dao.dart';
import 'dao/exercise_set_dao.dart';
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
  final exerciseSetDao = ExerciseSetDao();
  final composedWorkoutDao = ComposedWorkoutDao();
  final waterGoalDao = WaterGoalDao();
  final waterLogDao = WaterLogDao();

  late final _initializer = DatabaseInitializer();
  late final _mockDataInitializer = MockDataInitializer();

  static Database? _databaseInstance;
  Future<Database> get _database async {
    _databaseInstance ??= await _initializer.open();
    return _databaseInstance!;
  }

  String get dbPath => _initializer.dbPath;

  Future<void> init() async {
    await _database;
    await workoutDao.init(_database);
    await exerciseDao.init(_database);
    await workoutDetailDao.init(_database);
    await exerciseSetDao.init(_database);
    await composedWorkoutDao.init(_database);
    await waterGoalDao.init(_database);
    await waterLogDao.init(_database);

    if (_initializer.isFirstCreation && isMockupEnabled) {
      await _mockDataInitializer.initTestData();
    }
  }

  Future<void> restoreBackup(File backup) async {
    await _close();
    await backup.copy(dbPath);
    await init();
  }

  Future<void> _close() async {
    final database = await _database;
    await database.close();
    _databaseInstance = null;
  }
}
