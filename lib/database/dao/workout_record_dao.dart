import 'package:sqflite/sqflite.dart';

import '../model/workout_record_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class WorkoutRecordDao extends BaseDao<WorkoutRecordEntity> {
  @override
  Future<List<WorkoutRecordEntity>> getAll() async {
    final maps = await database.query(WorkoutRecordTable.name);
    final results = <WorkoutRecordEntity>[];
    for (final map in maps) {
      results.add(WorkoutRecordEntity.fromMap(map));
    }
    return results;
  }

  @override
  Future<int> insert(WorkoutRecordEntity entity) async {
    return await database.insert(
      WorkoutRecordTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
