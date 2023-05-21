import '../../util/log_util.dart';
import '../model/embedded_object/exercise_with_running_sets_entity.dart';
import '../model/embedded_object/exercise_with_weight_training_sets_entity.dart';
import '../model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import '../model/exercise_entity.dart';
import '../model/exercise_set_entity.dart';
import '../model/running_set_entity.dart';
import '../model/weight_training_set_entity.dart';
import '../model/workout_entity.dart';
import '../model/workout_type_entity.dart';
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
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutTypeId},
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutTypeNum},
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutCreateDateTime},
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutStartDateTime},
      ${WorkoutTable.name}.${WorkoutTable.columnWorkoutEndDateTime},
      ${ExerciseTable.name}.${ExerciseTable.columnExerciseId},
      ${ExerciseTable.name}.${ExerciseTable.columnExerciseName},
      ${WorkoutDetailTable.name}.${WorkoutDetailTable.columnExerciseCreateDateTime},
      CASE
        WHEN ${WeightTrainingSetTable.columnBaseWeight} IS NOT NULL THEN ${WeightTrainingSetTable.name}.${WeightTrainingSetTable.columnSetNum}
        WHEN ${RunningSetTable.columnDuration} IS NOT NULL THEN ${RunningSetTable.name}.${RunningSetTable.columnSetNum}
        ELSE NULL
      END AS $_columnSetNum,
      CASE
        WHEN ${WeightTrainingSetTable.columnBaseWeight} IS NOT NULL THEN ${WeightTrainingSetTable.name}.${WeightTrainingSetTable.columnSetEndDateTime}
        WHEN ${RunningSetTable.columnDuration} IS NOT NULL THEN ${RunningSetTable.name}.${RunningSetTable.columnSetEndDateTime}
        ELSE NULL
      END AS $_columnSetEndDateTime,
      ${WeightTrainingSetTable.columnBaseWeight},
      ${WeightTrainingSetTable.columnSideWeight},
      ${WeightTrainingSetTable.columnRepetition},
      ${RunningSetTable.columnDuration},
      ${RunningSetTable.columnDistance}
      FROM ${WorkoutTable.name}
      LEFT JOIN (
        ${WorkoutDetailTable.name}
        LEFT JOIN ${WeightTrainingSetTable.name} USING (${WorkoutDetailTable.columnWorkoutId}, ${WorkoutDetailTable.columnExerciseId})
        LEFT JOIN ${RunningSetTable.name} USING (${WorkoutDetailTable.columnWorkoutId}, ${WorkoutDetailTable.columnExerciseId})
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
        final isWeightTraining = _isWeightTraining(exerciseEntity);
        final isRunning = _isRunning(exerciseEntity);

        final exerciseWithSetsEntityMap =
            workoutWithExercisesAndSetsEntity.exerciseWithSetsEntityMap;
        final exerciseWithSetsEntity =
            exerciseWithSetsEntityMap.putIfAbsent(exerciseEntity, () {
          if (isWeightTraining) {
            return ExerciseWithWeightTrainingSetsEntity(
                exerciseEntity: exerciseEntity, exerciseSetEntities: []);
          } else if (isRunning) {
            return ExerciseWithRunningSetsEntity(
                exerciseEntity: exerciseEntity, exerciseSetEntities: []);
          } else {
            throw Exception("Unsupported exercise: $map");
          }
        });

        if (!_hasSet(map)) {
          continue;
        }

        final ExerciseSetEntity exerciseSetEntity;
        if (isWeightTraining) {
          exerciseSetEntity = WeightTrainingSetEntity.fromMap(map);
        } else if (isRunning) {
          exerciseSetEntity = RunningSetEntity.fromMap(map);
        } else {
          throw Exception("Unsupported set: $map");
        }
        exerciseWithSetsEntity.exerciseSetEntities.add(exerciseSetEntity);
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

  bool _isWeightTraining(ExerciseEntity exerciseEntity) =>
      exerciseEntity.workoutTypeEntity == WorkoutTypeEntity.weightTraining;

  bool _isRunning(ExerciseEntity exerciseEntity) =>
      exerciseEntity.workoutTypeEntity == WorkoutTypeEntity.running;

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
      where.add("${WorkoutTable.name}.${WorkoutTable.columnWorkoutId} in ($args)");
    }

    if (where.isEmpty) {
      return null;
    }

    return where.join(" AND ");
  }
}
