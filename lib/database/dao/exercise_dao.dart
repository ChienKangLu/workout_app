import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/exercise_entity.dart';
import '../model/workout_type_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class ExerciseDao extends BaseDao<ExerciseEntity> {
  static const _tag = "ExerciseDao";

  @override
  Future<void> init(Future<Database> database, bool firstCreation) async {
    await super.init(database, firstCreation);
    if (!firstCreation) {
      return;
    }

    await initTestData();
  }

  Future<void> initTestData() async {
    await insert(ExerciseEntity.create("Squat", WorkoutTypeEntity.weightTraining.id));
    await insert(ExerciseEntity.create("Bench Press", WorkoutTypeEntity.weightTraining.id));
    await insert(ExerciseEntity.create("Jogging", WorkoutTypeEntity.running.id));

    final result = await getAll();
    Log.d(_tag, "initTestData ${result.toString()}");
  }

  @override
  Future<List<ExerciseEntity>> getAll() async {
    final maps = await database.query(ExerciseTable.name);
    final results = <ExerciseEntity>[];
    for (final map in maps) {
      results.add(ExerciseEntity.fromMap(map));
    }
    return results;
  }

  @override
  Future<int> insert(ExerciseEntity entity) async {
    return await database.insert(
      ExerciseTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
