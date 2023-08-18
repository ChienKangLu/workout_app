import '../../util/log_util.dart';
import '../model/embedded_object/exercise_with_sets_entity.dart';
import '../model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import '../model/exercise_entity.dart';
import '../model/exercise_set_entity.dart';
import '../model/workout_entity.dart';
import '../schema.dart';
import 'base_dao.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

class ComposedWorkoutDao
    extends BaseDao<WorkoutWithExercisesAndSetsEntity, ComposedWorkoutFilter> {
  static const _tag = "ComposedWorkoutDao";
  static const String _columnSetNum = "set_num";
  static const String _columnSetEndDateTime = "set_end_date_time";

  @override
  Future<DaoResult<List<WorkoutWithExercisesAndSetsEntity>>> findAll() {
    return findByFilter(null);
  }

  @override
  Future<DaoResult<List<WorkoutWithExercisesAndSetsEntity>>> findByFilter(
    ComposedWorkoutFilter? filter,
  ) async {
    try {
      String query = '''
    SELECT
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutId},
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutCreateDateTime},
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutStartDateTime},
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutEndDateTime},
      ${ExerciseTable.name}.${ExerciseTable.columnExerciseId},
      ${ExerciseTable.name}.${ExerciseTable.columnExerciseName},
      ${WorkoutDetailTable.name}.${WorkoutDetailTable.columnExerciseCreateDateTime},
      ${ExerciseSetTable.name}.${ExerciseSetTable.columnSetNum} AS $_columnSetNum,
      ${ExerciseSetTable.name}.${ExerciseSetTable.columnSetEndDateTime}  AS $_columnSetEndDateTime,
      ${ExerciseSetTable.columnBaseWeight},
      ${ExerciseSetTable.columnSideWeight},
      ${ExerciseSetTable.columnRepetition}
      FROM ${WorkoutTable.name}
      LEFT JOIN (
        ${WorkoutDetailTable.name}
        LEFT JOIN ${ExerciseSetTable.name} USING (${WorkoutDetailTable.columnWorkoutId}, ${WorkoutDetailTable.columnExerciseId})
      )
      ON ${WorkoutTable.name}.${WorkoutTable.columnWorkoutId} = ${WorkoutDetailTable.name}.${WorkoutDetailTable.columnWorkoutId}
      LEFT JOIN ${ExerciseTable.name}
      ON ${ExerciseTable.name}.${ExerciseTable.columnExerciseId} = ${WorkoutDetailTable.name}.${WorkoutDetailTable.columnExerciseId}
      ''';

      final whereClause = filter?.toWhereClause();
      if (whereClause != null) {
        query += '''WHERE $whereClause''';
      }

      query += '''
      ORDER BY 
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutCreateDateTime} DESC, 
      ${WorkoutDetailTable.name}.${WorkoutDetailTable.columnExerciseCreateDateTime} ASC, 
      $_columnSetEndDateTime ASC
      ''';

      final maps = await database.rawQuery(query);

      final workoutWithExercisesAndSetsEntityMap =
          <WorkoutEntity, WorkoutWithExercisesAndSetsEntity>{};

      for (final map in maps) {
        final workoutEntity = WorkoutEntity.fromMap(map);
        final workoutWithExercisesAndSetsEntity =
            workoutWithExercisesAndSetsEntityMap.putIfAbsent(
          workoutEntity,
          () => WorkoutWithExercisesAndSetsEntity(
            workoutEntity: workoutEntity,
            exerciseWithSetsEntityMap: {},
          ),
        );

        if (!_hasExercise(map)) {
          continue;
        }

        final exerciseEntity = ExerciseEntity.fromMap(map);

        final exerciseWithSetsEntityMap =
            workoutWithExercisesAndSetsEntity.exerciseWithSetsEntityMap;
        final exerciseWithSetsEntity = exerciseWithSetsEntityMap.putIfAbsent(
          exerciseEntity,
          () => ExerciseWithSetsEntity(
            exerciseEntity: exerciseEntity,
            exerciseSetEntities: [],
          ),
        );

        if (!_hasSet(map)) {
          continue;
        }

        exerciseWithSetsEntity.exerciseSetEntities.add(
          ExerciseSetEntity.fromMap(map),
        );
      }

      final results =
          workoutWithExercisesAndSetsEntityMap.values.toList(growable: false);
      return DaoSuccess(results);
    } on Exception catch (e) {
      Log.e(_tag, "Cannot findByFilter with filter '$filter'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<int>> add(WorkoutWithExercisesAndSetsEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<DaoResult<bool>> update(WorkoutWithExercisesAndSetsEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<DaoResult<bool>> delete(ComposedWorkoutFilter filter) async {
    throw UnimplementedError();
  }

  bool _hasExercise(Map<String, dynamic> map) =>
      map[WorkoutDetailTable.columnExerciseId] != null;

  bool _hasSet(Map<String, dynamic> map) => map[_columnSetNum] != null;
}

class ComposedWorkoutFilter implements DaoFilter {
  ComposedWorkoutFilter({
    required this.workoutIds,
  });

  final List<int> workoutIds;

  @override
  String? toWhereClause() {
    final where = <String>[];
    if (workoutIds.isNotEmpty) {
      final args = workoutIds.join(",");
      where.add(
          "${WorkoutTable.name}.${WorkoutTable.columnWorkoutId} in ($args)");
    }

    if (where.isEmpty) {
      return null;
    }

    return where.join(" AND ");
  }
}
