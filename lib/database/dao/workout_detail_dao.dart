import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/workout_detail_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

class WorkoutDetailDao
    extends BaseDao<WorkoutDetailEntity, WorkoutDetailEntityFilter> {
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
  Future<DaoResult<bool>> delete(WorkoutDetailEntityFilter filter) async {
    try {
      final count = await database.delete(
        WorkoutDetailTable.name,
        where: filter.toWhereClause(),
      );
      Log.d(_tag, "Delete $count rows from '${WorkoutDetailTable.name}'");

      return DaoSuccess(true);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findByFilter with filter '$filter'", e);
      return DaoError(e);
    }
  }
}

class WorkoutDetailEntityFilter implements DaoFilter {
  WorkoutDetailEntityFilter({
    this.workoutIds = const [],
    this.workoutId,
    this.exerciseId,
  });

  List<int> workoutIds;
  int? workoutId;
  int? exerciseId;


  @override
  String? toWhereClause() {
    final where = <String>[];
    if (workoutIds.isNotEmpty) {
      final args = workoutIds.join(",");
      where.add("${WorkoutDetailTable.columnWorkoutId} in ($args)");
    }
    if (workoutId != null) {
      where.add("${WorkoutDetailTable.columnWorkoutId} = $workoutId");
    }
    if (exerciseId != null) {
      where.add("${WorkoutDetailTable.columnExerciseId} = $exerciseId");
    }

    if (where.isEmpty) {
      return null;
    }

    return where.join(" AND ");
  }
}
