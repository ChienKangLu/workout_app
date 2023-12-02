import 'dart:io';

import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../util/log_util.dart';
import 'dao/composed_workout_dao.dart';
import 'dao/exercise_dao.dart';
import 'dao/water_goal_dao.dart';
import 'dao/water_log_dao.dart';
import 'dao/exercise_set_dao.dart';
import 'dao/workout_dao.dart';
import 'dao/workout_detail_dao.dart';
import 'database_initializer.dart';

class WorkoutDatabase {
  static const _tag = "WorkoutDatabase";

  WorkoutDatabase._();

  static WorkoutDatabase? _instance;
  static WorkoutDatabase get instance => _instance ??= WorkoutDatabase._();

  final workoutDao = WorkoutDao();
  final exerciseDao = ExerciseDao();
  final workoutDetailDao = WorkoutDetailDao();
  final exerciseSetDao = ExerciseSetDao();
  final composedWorkoutDao = ComposedWorkoutDao();
  final waterGoalDao = WaterGoalDao();
  final waterLogDao = WaterLogDao();

  late DatabaseInitializer _initializer = DatabaseInitializer();

  static Database? _databaseInstance;
  Future<Database> get _database async {
    return _databaseInstance ??= await _initializer.open();
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
  }

  Future<void> restoreBackup(File backup) async {
    await close();
    try {
      await backup.copy(dbPath);
    } catch (e) {
      Log.e(_tag, "Cannot copy backup, error = $e");
    }
    await init();
  }

  Future<void> close() async {
    final database = await _database;
    await database.close();
    _databaseInstance = null;
  }

  @visibleForTesting
  void setUpDatabaseInitializer(DatabaseInitializer databaseInitializer) {
    _initializer = databaseInitializer;
  }

  @visibleForTesting
  static void setUpInstance(WorkoutDatabase instance) {
    _instance = instance;
  }
}
