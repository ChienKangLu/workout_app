import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/running_set_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

class RunningSetDao extends BaseDao<RunningSetEntity, RunningSetEntityFilter> {
  static const _tag = "RunningSetDao";

  @override
  Future<DaoResult<List<RunningSetEntity>>> findAll() async {
    try {
      final maps = await database.query(RunningSetTable.name);
      final results = <RunningSetEntity>[];
      for (final map in maps) {
        results.add(RunningSetEntity.fromMap(map));
      }

      return DaoSuccess(results);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findAll", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<List<RunningSetEntity>>> findByFilter(
    RunningSetEntityFilter? filter,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<DaoResult<int>> add(RunningSetEntity entity) async {
    try {
      final id = await database.insert(
        RunningSetTable.name,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return DaoSuccess(id);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<bool>> update(RunningSetEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<DaoResult<bool>> delete(RunningSetEntityFilter filter) async {
    try {
      final count = await database.delete(
        RunningSetTable.name,
        where: filter.toWhereClause(),
      );
      Log.d(_tag, "Delete $count rows from '${RunningSetTable.name}'");

      return DaoSuccess(true);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findByFilter with filter '$filter'", e);
      return DaoError(e);
    }
  }
}

class RunningSetEntityFilter implements DaoFilter {
  RunningSetEntityFilter({
    required this.workoutIds,
  });

  final List<int> workoutIds;

  @override
  String? toWhereClause() {
    final where = <String>[];
    if (workoutIds.isNotEmpty) {
      final args = workoutIds.join(",");
      where.add("${RunningSetTable.columnWorkoutId} in ($args)");
    }

    if (where.isEmpty) {
      return null;
    }

    return where.join(" AND ");
  }
}
