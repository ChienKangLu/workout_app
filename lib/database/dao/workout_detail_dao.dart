import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/workout_detail_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao.dart';
import 'dao_filter.dart';

class WorkoutDetailDao extends BaseDao<WorkoutDetailEntity, DaoFilter> {
  static const _tag = "WorkoutDetailDao";

  @override
  Future<List<WorkoutDetailEntity>> findAll() async {
    try {
      final maps = await database.query(WorkoutDetailTable.name);
      final results = <WorkoutDetailEntity>[];
      for (final map in maps) {
        results.add(WorkoutDetailEntity.fromMap(map));
      }
      return results;
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findAll", e);
      return [];
    }
  }

  @override
  Future<List<WorkoutDetailEntity>> findByFilter(DaoFilter? filter) {
    throw UnimplementedError();
  }

  @override
  Future<int> add(WorkoutDetailEntity entity) async {
    try {
      return await database.insert(
        WorkoutDetailTable.name,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return Dao.invalidId;
    }
  }

  @override
  Future<bool> update(WorkoutDetailEntity entity) {
    throw UnimplementedError();
  }
}
