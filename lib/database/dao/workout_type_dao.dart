import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/workout_type_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class WorkoutTypeDao extends BaseDao<WorkoutTypeEntity> {
  static const _tag = "WorkoutTypeDao";

  @override
  Future<void> init(Future<Database> database, bool firstCreation) async {
    await super.init(database, firstCreation);
    if (!firstCreation) {
      return;
    }

    await insert(WorkoutTypeEntity.create("weight training"));
    await insert(WorkoutTypeEntity.create("running"));

    final result = await getAll();
    Log.d(_tag, "init ${result.toString()}");
  }

  @override
  Future<List<WorkoutTypeEntity>> getAll() async {
    final maps = await database.query(WorkoutTypeTable.name);
    final results = <WorkoutTypeEntity>[];
    for (final map in maps) {
      results.add(WorkoutTypeEntity.fromMap(map));
    }
    return results;
  }

  @override
  Future<int> insert(WorkoutTypeEntity entity) async {
    return await database.insert(
      WorkoutTypeTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
