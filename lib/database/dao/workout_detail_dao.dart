import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/workout_detail_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

class WorkoutDetailDao extends BaseDao<WorkoutDetailEntity, DaoFilter> {
  static const _tag = "WorkoutDetailDao";

  @override
  Future<DaoResult<List<WorkoutDetailEntity>>> findAll() async {
    try {
      final maps = await database.query(WorkoutDetailTable.name);
      final results = <WorkoutDetailEntity>[];
      for (final map in maps) {
        results.add(WorkoutDetailEntity.fromMap(map));
      }

      return DaoSuccess(results);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findAll", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<List<WorkoutDetailEntity>>> findByFilter(DaoFilter? filter) {
    throw UnimplementedError();
  }

  @override
  Future<DaoResult<int>> add(WorkoutDetailEntity entity) async {
    try {
      final result = await database.insert(
        WorkoutDetailTable.name,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return DaoSuccess(result);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<bool>> update(WorkoutDetailEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<DaoResult<bool>> delete(List<int> ids) {
    throw UnimplementedError();
  }
}
