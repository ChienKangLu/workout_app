import 'package:sqflite/sqflite.dart';

import 'dao/workout_record_dao.dart';
import 'dao/workout_type_dao.dart';
import 'database_initializer.dart';

class WorkoutDatabase {
  WorkoutDatabase._();
  static final WorkoutDatabase instance = WorkoutDatabase._();

  final workoutTypeDao = WorkoutTypeDao();
  final workoutRecordDao = WorkoutRecordDao();

  late final _initializer = DatabaseInitializer();

  static Database? _databaseInstance;
  Future<Database> get _database async {
    _databaseInstance ??= await _initializer.open();
    return _databaseInstance!;
  }

  Future<void> init() async {
    await _database;

    await workoutTypeDao.init(_database, _initializer.firstCreation);
    await workoutRecordDao.init(_database, _initializer.firstCreation);
  }
}