import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/workout_entity.dart';
import '../schema.dart';
import 'dao.dart';

class WorkoutDao implements Dao<WorkoutEntity>{
  static const _tag= "WorkoutDao";

  late final Future<Database> _database;

  @override
  Future<void> init(Future<Database> database, bool firstCreation) async {
    _database = database;
    if (!firstCreation) {
      return;
    }

    await insert(WorkoutEntity(ignoredId, "weight training"));
    await insert(WorkoutEntity(ignoredId, "running"));

    final result = await getAll();
    Log.d(_tag, "init ${result.toString()}");
  }

  @override
  Future<List<WorkoutEntity>> getAll() async {
    final database = await _database;
    final maps = await database.query(WorkoutTable.name);
    final results = <WorkoutEntity>[];
    for (final map in maps) {
      results.add(WorkoutEntity.fromMap(map));
    }
    return results;
  }

  @override
  Future<void> insert(WorkoutEntity entity) async {
    final database = await _database;
    database.insert(
      WorkoutTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}