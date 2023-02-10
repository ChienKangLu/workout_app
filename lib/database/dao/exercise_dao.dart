import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/exercise_entity.dart';
import '../model/workout_type_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

class ExerciseDao extends BaseDao<ExerciseEntity, ExerciseEntityFilter> {
  static const _tag = "ExerciseDao";

  @override
  Future<DaoResult<List<ExerciseEntity>>> findAll() async {
    return findByFilter(null);
  }

  @override
  Future<DaoResult<List<ExerciseEntity>>> findByFilter(
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

      return DaoSuccess(results);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findByFilter with filter '$filter'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<int>> add(ExerciseEntity entity) async {
    try {
      final id = await database.insert(
        ExerciseTable.name,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return DaoSuccess(id);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot add entity '$entity'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<bool>> update(ExerciseEntity entity) {
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
