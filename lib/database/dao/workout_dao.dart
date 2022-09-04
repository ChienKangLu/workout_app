import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/workout_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class WorkoutDao extends BaseDao<WorkoutEntity> {
  static const _tag = "WorkoutDao";

  @override
  Future<void> init(Future<Database> database, bool firstCreation) async {
    await super.init(database, firstCreation);
    if (!firstCreation) {
      return;
    }

    await insert(WorkoutEntity.create("weight training"));
    await insert(WorkoutEntity.create("running"));

    final result = await getAll();
    Log.d(_tag, "init ${result.toString()}");
  }

  @override
  Future<List<WorkoutEntity>> getAll() async {
    final maps = await database.query(WorkoutTable.name);
    final results = <WorkoutEntity>[];
    for (final map in maps) {
      results.add(WorkoutEntity.fromMap(map));
    }
    return results;
  }

  @override
  Future<int> insert(WorkoutEntity entity) async {
    return await database.insert(
      WorkoutTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
