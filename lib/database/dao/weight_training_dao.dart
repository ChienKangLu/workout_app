import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/weight_training_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class WeightTrainingDao extends BaseDao<WeightTrainingEntity> {
  static const _tag = "WeightTrainingDao";

  @override
  Future<void> init(Future<Database> database, bool firstCreation) async {
    await super.init(database, firstCreation);
    if (!firstCreation) {
      return;
    }

    await initTestData();
  }

  Future<void> initTestData() async {
    await insert(WeightTrainingEntity(
        1, 1, 1, 20, 15, 5, DateTime.now().microsecondsSinceEpoch));
    await insert(WeightTrainingEntity(
        1, 1, 2, 20, 17.5, 5, DateTime.now().microsecondsSinceEpoch));
    await insert(WeightTrainingEntity(
        1, 2, 1, 20, 20, 5, DateTime.now().microsecondsSinceEpoch));

    final result = await getAll();
    Log.d(_tag, "initTestData ${result.toString()}");
  }

  @override
  Future<List<WeightTrainingEntity>> getAll() async {
    final maps = await database.query(WeightTrainingTable.name);
    final results = <WeightTrainingEntity>[];
    for (final map in maps) {
      results.add(WeightTrainingEntity.fromMap(map));
    }
    return results;
  }

  @override
  Future<int> insert(WeightTrainingEntity entity) async {
    return await database.insert(
      WeightTrainingTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
