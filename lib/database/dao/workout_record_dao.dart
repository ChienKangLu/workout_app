import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/workout_record_entity.dart';
import '../model/workout_type_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class WorkoutRecordDao extends BaseDao<WorkoutRecordEntity> {
  static const _tag = "WorkoutRecordDao";

  @override
  Future<void> init(Future<Database> database, bool firstCreation) async {
    await super.init(database, firstCreation);
    if (!firstCreation) {
      return;
    }

    await initTestData();
  }

  Future<void> initTestData() async {
    await insert(WorkoutRecordEntity.create(WorkoutTypeEntity.weightTraining.id));
    await insert(WorkoutRecordEntity.create(WorkoutTypeEntity.running.id));

    final result = await getAll();
    Log.d(_tag, "initTestData ${result.toString()}");
  }

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
