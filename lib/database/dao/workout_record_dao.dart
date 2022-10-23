import 'package:sqflite/sqflite.dart';

import '../model/workout_record_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class WorkoutRecordDao extends BaseDao<WorkoutRecordEntity> {
  static const _tag = "WorkoutRecordDao";

  Future<List<WorkoutRecordEntity>> getWorkoutRecordEntities({
    int? workoutRecordId,
  }) async {
    final maps = await database.query(WorkoutRecordTable.name,
        where: workoutRecordId != null
            ? "${WorkoutRecordTable.columnWorkoutRecordId} = ?"
            : null,
        whereArgs: workoutRecordId != null ? [workoutRecordId] : null,
        orderBy: "${WorkoutRecordTable.columnCreateDateTime} DESC");
    final results = <WorkoutRecordEntity>[];
    for (final map in maps) {
      results.add(WorkoutRecordEntity.fromMap(map));
    }
    return results;
  }

  Future<int> insertWorkoutRecord(WorkoutRecordEntity entity) async {
    final int lastWorkoutTypeIndex =
        await _getLastWorkoutTypeIndex(entity.workoutTypeId);

    final workoutTypeIndex = lastWorkoutTypeIndex + 1;

    final entityMap = entity.toMap();
    entityMap[WorkoutRecordTable.columnWorkoutTypeIndex] = workoutTypeIndex;

    return await database.insert(
      WorkoutRecordTable.name,
      entityMap,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<bool> update(WorkoutRecordEntity entity) async {
    final count = await database.update(
      WorkoutRecordTable.name,
      entity.toMap(),
      where: '${WorkoutRecordTable.columnWorkoutRecordId} = ?',
      whereArgs: [entity.workoutRecordId],
    );
    return count == 1;
  }

  Future<int> _getLastWorkoutTypeIndex(int workoutTypeId) async {
    final lastWorkoutTypeIndexResults = await database.query(
      WorkoutRecordTable.name,
      columns: [WorkoutRecordTable.columnWorkoutTypeIndex],
      where: "${WorkoutRecordTable.columnWorkoutTypeId} = ?",
      whereArgs: [workoutTypeId],
      orderBy: "${WorkoutRecordTable.columnWorkoutTypeIndex} DESC",
      limit: 1,
    );

    if (lastWorkoutTypeIndexResults.isEmpty) {
      return -1;
    }

    return lastWorkoutTypeIndexResults[0]
        [WorkoutRecordTable.columnWorkoutTypeIndex] as int;
  }
}
