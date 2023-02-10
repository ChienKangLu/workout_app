import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/weight_training_set_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

class WeightTrainingSetDao extends BaseDao<WeightTrainingSetEntity, DaoFilter> {
  static const _tag = "WeightTrainingSetDao";
  static const _initSetNum = 1;

  @override
  Future<DaoResult<List<WeightTrainingSetEntity>>> findAll() async {
    try {
      final maps = await database.query(WeightTrainingSetTable.name);
      final results = <WeightTrainingSetEntity>[];
      for (final map in maps) {
        results.add(WeightTrainingSetEntity.fromMap(map));
      }
      return DaoSuccess(results);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findAll", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<List<WeightTrainingSetEntity>>> findByFilter(
      DaoFilter? filter) {
    throw UnimplementedError();
  }

  @override
  Future<DaoResult<int>> add(WeightTrainingSetEntity entity) async {
    try {
      final lastSetNum =
          await _getLastSetNum(entity.workoutId, entity.exerciseId);

      final int setNum;
      if (lastSetNum == -1) {
        setNum = _initSetNum;
      } else {
        setNum = lastSetNum + 1;
      }

      final entityMap = entity.toMap();
      entityMap[WeightTrainingSetTable.columnSetNum] = setNum;

      final id = await database.insert(
        WeightTrainingSetTable.name,
        entityMap,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return DaoSuccess(id);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return DaoError(e);
    }
  }

  Future<int> _getLastSetNum(
    int workoutId,
    int exerciseId,
  ) async {
    final lastSetNumResults = await database.query(
      WeightTrainingSetTable.name,
      columns: [WeightTrainingSetTable.columnSetNum],
      where:
          "${WeightTrainingSetTable.columnWorkoutId} = ? AND ${WeightTrainingSetTable.columnExerciseId} = ?",
      whereArgs: [workoutId, exerciseId],
      orderBy: "${WeightTrainingSetTable.columnSetNum} DESC",
      limit: 1,
    );

    if (lastSetNumResults.isEmpty) {
      return -1;
    }

    return lastSetNumResults[0][WeightTrainingSetTable.columnSetNum] as int;
  }

  @override
  Future<DaoResult<bool>> update(WeightTrainingSetEntity entity) {
    throw UnimplementedError();
  }
}
