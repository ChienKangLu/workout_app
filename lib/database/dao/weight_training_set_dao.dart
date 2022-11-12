import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/weight_training_set_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao.dart';
import 'dao_filter.dart';

class WeightTrainingSetDao extends BaseDao<WeightTrainingSetEntity, DaoFilter> {
  static const _tag = "WeightTrainingSetDao";

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
      return await database.insert(
        WeightTrainingSetTable.name,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return Dao.invalidId;
    }
  }

  @override
  Future<bool> update(WeightTrainingSetEntity entity) {
    throw UnimplementedError();
  }
}
