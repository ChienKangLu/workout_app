import 'package:sqflite/sqflite.dart';

import 'dao/exercise_dao.dart';
import 'dao/runing_dao.dart';
import 'dao/weight_training_dao.dart';
import 'dao/workout_record_dao.dart';
import 'database_initializer.dart';

class WorkoutDatabase {
  WorkoutDatabase._();
  static final WorkoutDatabase instance = WorkoutDatabase._();

  final workoutRecordDao = WorkoutRecordDao();
  final exerciseDao = ExerciseDao();
  final weightTrainingDao = WeightTrainingDao();
  final runningDao = RunningDao();

  late final _initializer = DatabaseInitializer();

  static Database? _databaseInstance;
  Future<Database> get _database async {
    _databaseInstance ??= await _initializer.open();
    return _databaseInstance!;
  }

  Future<void> init() async {
    await _database;

    await workoutRecordDao.init(_database, _initializer.firstCreation);
    await exerciseDao.init(_database, _initializer.firstCreation);
    await weightTrainingDao.init(_database, _initializer.firstCreation);
    await runningDao.init(_database, _initializer.firstCreation);
  }
}