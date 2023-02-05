import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/weight_training_set_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao.dart';
import 'dao_filter.dart';

class WeightTrainingSetDao extends BaseDao<WeightTrainingSetEntity, DaoFilter> {
  static const _tag = "WeightTrainingSetDao";
  static const _initSetNum = 1;

  @override
  Future<List<WeightTrainingSetEntity>> findAll() async {
    try {
      final maps = await database.query(WeightTrainingSetTable.name);
      final results = <WeightTrainingSetEntity>[];
      for (final map in maps) {
        results.add(WeightTrainingSetEntity.fromMap(map));
      }
      return results;
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findAll", e);
      return [];
    }
  }

  @override
  Future<List<WeightTrainingSetEntity>> findByFilter(DaoFilter? filter) {
    throw UnimplementedError();
  }

  @override
  Future<int> add(WeightTrainingSetEntity entity) async {
    try {
      final lastSetNum =
          await _getLastSetNum(entity.workoutId, entity.exerciseId);

      if (lastSetNum == null) {
        Log.e(_tag, "Cannot add entity because error while _getLastSetNum");
        return Dao.invalidId;
      }

      final int setNum;
      if (lastSetNum == -1) {
        setNum = _initSetNum;
      } else {
        setNum = lastSetNum + 1;
      }

      final entityMap = entity.toMap();
      entityMap[WeightTrainingSetTable.columnSetNum] = setNum;

      return await database.insert(
        WeightTrainingSetTable.name,
        entityMap,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return Dao.invalidId;
    }
  }

  Future<int?> _getLastSetNum(
    int workoutId,
    int exerciseId,
  ) async {
    try {
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
    } on Exception catch (e) {
      Log.e(
          _tag,
          "Cannot _getLastSetNum, workoutId: $workoutId, exerciseId: $exerciseId",
          e);
      return null;
    }
  }

  @override
  Future<bool> update(WeightTrainingSetEntity entity) {
    throw UnimplementedError();
  }
}
