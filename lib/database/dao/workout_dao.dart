import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/workout_entity.dart';
import '../model/workout_type_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

class WorkoutDao extends BaseDao<WorkoutEntity, WorkoutEntityFilter> {
  static const _tag = "WorkoutDao";
  static const _initWorkoutTypeNum = 0;

  @override
  Future<DaoResult<List<WorkoutEntity>>> findAll() {
    return findByFilter(null);
  }

  @override
  Future<DaoResult<List<WorkoutEntity>>> findByFilter(
    WorkoutEntityFilter? filter,
  ) async {
    try {
      final maps = await database.query(
        WorkoutTable.name,
        where: filter?.toWhereClause(),
      );
      final results = <WorkoutEntity>[];
      for (final map in maps) {
        results.add(WorkoutEntity.fromMap(map));
      }
      return DaoSuccess(results);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findByFilter with filter '$filter'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<int>> add(WorkoutEntity entity) async {
    try {
      final lastWorkoutTypeNum =
          await _getLastWorkoutTypeNum(entity.workoutTypeEntity);

      final int workoutTypeNum;
      if (lastWorkoutTypeNum == -1) {
        workoutTypeNum = _initWorkoutTypeNum;
      } else {
        workoutTypeNum = lastWorkoutTypeNum + 1;
      }

      final entityMap = entity.toMap();
      entityMap[WorkoutTable.columnWorkoutTypeNum] = workoutTypeNum;

      final id = await database.insert(
        WorkoutTable.name,
        entityMap,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return DaoSuccess(id);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<bool>> update(WorkoutEntity entity) async {
    try {
      final count = await database.update(
        WorkoutTable.name,
        entity.toMap(),
        where: '${WorkoutTable.columnWorkoutId} = ?',
        whereArgs: [entity.workoutId],
      );

      if (count != 1) {
        Log.w(_tag, "update more than one entry");
      }

      final result = count == 1;

      return DaoSuccess(result);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot update entity '$entity'", e);
      return DaoError(e);
    }
  }

  Future<int> _getLastWorkoutTypeNum(
    WorkoutTypeEntity workoutTypeEntity,
  ) async {
    final lastWorkoutTypeNumResults = await database.query(
      WorkoutTable.name,
      columns: [WorkoutTable.columnWorkoutTypeNum],
      where: "${WorkoutTable.columnWorkoutTypeId} = ?",
      whereArgs: [workoutTypeEntity.id],
      orderBy: "${WorkoutTable.columnWorkoutTypeNum} DESC",
      limit: 1,
    );

    if (lastWorkoutTypeNumResults.isEmpty) {
      return -1;
    }

    return lastWorkoutTypeNumResults[0][WorkoutTable.columnWorkoutTypeNum]
        as int;
  }
}

class WorkoutEntityFilter implements DaoFilter {
  WorkoutEntityFilter({
    this.workoutId,
  });

  final int? workoutId;

  @override
  String toWhereClause() {
    final where = <String>[];
    if (workoutId != null) {
      where.add("${WorkoutTable.columnWorkoutId} = $workoutId");
    }
    return where.join(",");
  }
}
