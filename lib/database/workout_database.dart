import 'package:sqflite/sqflite.dart';

import '../util/log_util.dart';
import 'dao/workout_dao.dart';
import 'database_initializer.dart';
import 'schema.dart';

class WorkoutDatabase {
  static const _tag= "WorkoutDatabase";

  WorkoutDatabase._();
  static final WorkoutDatabase instance = WorkoutDatabase._();

  late final _initializer = DatabaseInitializer(
    onInitData: (database) => _onInitData(database),
  );

  static Database? _databaseInstance;
  Future<Database> get _database async {
    _databaseInstance ??= await _initializer.open();
    return _databaseInstance!;
  }

  Future<void> init() async {
    await _database;
  }

  Future<void> _onInitData(Database database) async {
    Log.d(_tag, "_onInitData");

    final weightTraining = WorkoutDao(ignoredId, "weight training");
    await insertWorkout(weightTraining, database);

    final running = WorkoutDao(ignoredId, "running");
    await insertWorkout(running, database);
  }

  Future<void> insertWorkout(WorkoutDao workoutDao, [Database? initDatabase]) async {
    final database = initDatabase ?? await _database;
    database.insert(
      WorkoutTable.name,
      workoutDao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}