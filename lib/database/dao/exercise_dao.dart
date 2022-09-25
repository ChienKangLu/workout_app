import 'package:sqflite/sqflite.dart';

import '../model/exercise_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class ExerciseDao extends BaseDao<ExerciseEntity> {
  static const _tag = "ExerciseDao";

  Future<List<ExerciseEntity>> getExerciseEntities() async {
    final maps = await database.query(ExerciseTable.name);
    final results = <ExerciseEntity>[];
    for (final map in maps) {
      results.add(ExerciseEntity.fromMap(map));
    }
    return results;
  }

  Future<int> insertExercise(ExerciseEntity entity) async {
    return await database.insert(
      ExerciseTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
