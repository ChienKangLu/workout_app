import 'package:sqflite/sqflite.dart';

import '../model/embedded_object/running_with_exercise_entity.dart';
import '../model/running_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class RunningDao extends BaseDao<RunningEntity> {
  static const _tag = "RunningDao";

  Future<List<RunningEntity>> getRunningEntities() async {
    final maps = await database.query(RunningTable.name);
    final results = <RunningEntity>[];
    for (final map in maps) {
      results.add(RunningEntity.fromMap(map));
    }
    return results;
  }

  Future<List<RunningWithExerciseEntity>> getRunningWithExerciseEntities({
    int? workoutRecordId,
  }) async {
    final where = workoutRecordId != null
        ? "WHERE ${RunningTable.name}.${RunningTable.columnWorkoutRecordId} = $workoutRecordId"
        : "";

    final maps = await database.rawQuery('''        
    SELECT * FROM ${RunningTable.name}
    LEFT JOIN ${ExerciseTable.name} ON ${RunningTable.name}.${RunningTable.columnExerciseTypeId} = ${ExerciseTable.name}.${ExerciseTable.columnExerciseTypeId}
    $where 
    ORDER BY ${RunningTable.name}.${RunningTable.columnEndDateTime} DESC
    ''');
    final results = <RunningWithExerciseEntity>[];
    for (final map in maps) {
      results.add(RunningWithExerciseEntity.fromMap(map));
    }
    return results;
  }

  Future<int> insertRunning(RunningEntity entity) async {
    return await database.insert(
      RunningTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
