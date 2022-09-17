import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/running_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class RunningDao extends BaseDao<RunningEntity> {
  static const _tag = "RunningDao";

  @override
  Future<void> init(Future<Database> database, bool firstCreation) async {
    await super.init(database, firstCreation);
    if (!firstCreation) {
      return;
    }

    await initTestData();
  }

  Future<void> initTestData() async {
    await insert(RunningEntity(
        2, 3, 1, const Duration(minutes: 2).inMilliseconds.toDouble(), 400));
    await insert(RunningEntity(
        2, 3, 2, const Duration(minutes: 1, seconds: 30).inMilliseconds.toDouble(), 400));
    await insert(RunningEntity(
        2, 3, 3, const Duration(minutes: 3).inMilliseconds.toDouble(), 400));

    final result = await getAll();
    Log.d(_tag, "initTestData ${result.toString()}");
  }

  @override
  Future<List<RunningEntity>> getAll() async {
    final maps = await database.query(RunningTable.name);
    final results = <RunningEntity>[];
    for (final map in maps) {
      results.add(RunningEntity.fromMap(map));
    }
    return results;
  }

  @override
  Future<int> insert(RunningEntity entity) async {
    return await database.insert(
      RunningTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
