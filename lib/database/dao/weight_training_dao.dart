import 'package:sqflite/sqflite.dart';

import '../model/embedded_object/weight_training_with_exercise_entity.dart';
import '../model/weight_training_entity.dart';
import '../schema.dart';
import 'base_dao.dart';

class WeightTrainingDao extends BaseDao<WeightTrainingEntity> {
  static const _tag = "WeightTrainingDao";

  Future<List<WeightTrainingEntity>> getWeightTrainingEntities() async {
    final maps = await database.query(WeightTrainingTable.name);
    final results = <WeightTrainingEntity>[];
    for (final map in maps) {
      results.add(WeightTrainingEntity.fromMap(map));
    }
    return results;
  }

  Future<List<WeightTrainingWithExerciseEntity>>
      getWeightTrainingWithExerciseEntities({
    int? workoutRecordId,
  }) async {
    final where = workoutRecordId != null
        ? "WHERE ${WeightTrainingTable.name}.${WeightTrainingTable.columnWorkoutRecordId} = $workoutRecordId"
        : "";

    final maps = await database.rawQuery('''        
    SELECT * FROM ${WeightTrainingTable.name}
    LEFT JOIN ${ExerciseTable.name} ON ${WeightTrainingTable.name}.${WeightTrainingTable.columnExerciseTypeId} = ${ExerciseTable.name}.${ExerciseTable.columnExerciseTypeId}
    $where 
    ORDER BY
    ${WeightTrainingTable.name}.${WeightTrainingTable.columnEndDateTime} ASC
    ''');
    final results = <WeightTrainingWithExerciseEntity>[];
    for (final map in maps) {
      results.add(WeightTrainingWithExerciseEntity.fromMap(map));
    }
    return results;
  }

  Future<int> insertWeightTraining(WeightTrainingEntity entity) async {
    return await database.insert(
      WeightTrainingTable.name,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
