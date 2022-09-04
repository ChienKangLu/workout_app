import 'package:sqflite/sqflite.dart';

import '../model/record_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class RecordDao extends BaseDao<RecordEntity> {
  @override
  Future<List<RecordEntity>> getAll() async {
    final maps = await database.query(RecordTable.name);
    final results = <RecordEntity>[];
    for (final map in maps) {
      results.add(RecordEntity.fromMap(map));
    }
    return results;
  }

  @override
  Future<int> insert(RecordEntity entity) async {
    return await database.insert(
      RecordTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
