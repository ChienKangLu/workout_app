import 'package:sqflite/sqflite.dart';

import 'dao/record_dao.dart';
import 'dao/workout_dao.dart';
import 'database_initializer.dart';

class WorkoutDatabase {
  WorkoutDatabase._();
  static final WorkoutDatabase instance = WorkoutDatabase._();

  final WorkoutDao workoutDao = WorkoutDao();
  final RecordDao recordDao = RecordDao();

  late final _initializer = DatabaseInitializer();

  static Database? _databaseInstance;
  Future<Database> get _database async {
    _databaseInstance ??= await _initializer.open();
    return _databaseInstance!;
  }

  Future<void> init() async {
    await _database;

    await workoutDao.init(_database, _initializer.firstCreation);
    await recordDao.init(_database, _initializer.firstCreation);
  }
}