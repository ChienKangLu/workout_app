import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/exercise_entity.dart';
import '../model/workout_type_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao.dart';
import 'dao_filter.dart';

class ExerciseDao extends BaseDao<ExerciseEntity, ExerciseEntityFilter> {
  static const _tag = "ExerciseDao";

  @override
  Future<List<ExerciseEntity>> findAll() async {
    return findByFilter(null);
  }

  @override
  Future<List<ExerciseEntity>> findByFilter(
    ExerciseEntityFilter? filter,
  ) async {
    try {
      final maps = await database.query(
        ExerciseTable.name,
        where: filter?.toWhereClause(),
      );
      final results = <ExerciseEntity>[];
      for (final map in maps) {
        results.add(ExerciseEntity.fromMap(map));
      }
      return results;
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findByFilter with filter '$filter'", e);
      return [];
    }
  }

  @override
  Future<int> add(ExerciseEntity entity) async {
    try {
      return await database.insert(
        ExerciseTable.name,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return Dao.invalidId;
    }
  }

  @override
  Future<bool> update(ExerciseEntity entity) {
    throw UnimplementedError();
  }
}

class ExerciseEntityFilter implements DaoFilter {
  ExerciseEntityFilter({
    this.workoutTypeEntity,
    this.exerciseName,
  });

  final WorkoutTypeEntity? workoutTypeEntity;
  final String? exerciseName;

  @override
  String toWhereClause() {
    final where = <String>[];
    final workoutTypeEntity = this.workoutTypeEntity;
    if (workoutTypeEntity != null) {
      where.add("${ExerciseTable.columnWorkoutTypeId} = ${workoutTypeEntity.id}");
    }
    if (exerciseName != null) {
      where.add("${ExerciseTable.columnExerciseName} = $exerciseName");
    }
    return where.join(",");
  }
}
