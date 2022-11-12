import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/running_set_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao.dart';
import 'dao_filter.dart';

class RunningSetDao extends BaseDao<RunningSetEntity, DaoFilter> {
  static const _tag = "RunningSetDao";

  @override
  Future<List<RunningSetEntity>> findAll() async {
    try {
      final maps = await database.query(RunningSetTable.name);
      final results = <RunningSetEntity>[];
      for (final map in maps) {
        results.add(RunningSetEntity.fromMap(map));
      }
      return results;
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findAll", e);
      return [];
    }
  }

  @override
  Future<List<RunningSetEntity>> findByFilter(DaoFilter? filter) {
    throw UnimplementedError();
  }

  @override
  Future<int> add(RunningSetEntity entity) async {
    try {
      return await database.insert(
        RunningSetTable.name,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return Dao.invalidId;
    }
  }

  @override
  Future<bool> update(RunningSetEntity entity) {
    throw UnimplementedError();
  }
}
