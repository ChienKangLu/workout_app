import '../../util/log_util.dart';
import '../model/exercise_statistic_entity.dart';
import '../model/exercise_set_entity.dart';
import '../schema.dart';
import 'dao_filter.dart';
import 'dao_result.dart';
import 'simple_dao.dart';

class ExerciseSetDao
    extends SimpleDao<ExerciseSetEntity, ExerciseSetEntityFilter> {
  static const _tag = "ExerciseSetDao";
  static const _initSetNum = 1;

  @override
  String get tag => _tag;

  @override
  String get tableName => ExerciseSetTable.name;

  @override
  ExerciseSetEntity createEntityFromMap(Map<String, dynamic> map) =>
      ExerciseSetEntity.fromMap(map);

  @override
  ExerciseSetEntityFilter createUpdateFilter(ExerciseSetEntity entity) =>
      ExerciseSetEntityFilter(
        workoutId: entity.workoutId,
        exerciseId: entity.exerciseId,
        setNum: entity.setNum,
      );

  @override
  Future<DaoResult<int>> add(ExerciseSetEntity entity) async {
    final lastSetNum =
        await _getLastSetNum(entity.workoutId, entity.exerciseId);

    final int setNum;
    if (lastSetNum == -1) {
      setNum = _initSetNum;
    } else {
      setNum = lastSetNum + 1;
    }

    return super.add(
      ExerciseSetEntity(
        workoutId: entity.workoutId,
        exerciseId: entity.exerciseId,
        setNum: setNum,
        baseWeight: entity.baseWeight,
        sideWeight: entity.sideWeight,
        repetition: entity.repetition,
        endDateTime: entity.endDateTime,
      ),
    );
  }

  Future<DaoResult<ExerciseStatisticEntity>> getStatistic(
    int exerciseId,
  ) async {
    try {
      final monthlyMaxWeightEntities =
          await getMonthlyMaxWeightEntities(exerciseId);
      return DaoSuccess(ExerciseStatisticEntity(
        monthlyMaxWeightEntities: monthlyMaxWeightEntities,
      ));
    } on Exception catch (e) {
      Log.e(tag, "Cannot getStatistic with exercise_id '$exerciseId'", e);
      return DaoError(e);
    }
  }

  Future<List<MonthlyMaxWeightEntity>> getMonthlyMaxWeightEntities(
    int exerciseId,
  ) async {
    try {
      final maps = await database.rawQuery("""
      SELECT 
        max(${ExerciseSetTable.columnBaseWeight} + 2 * ${ExerciseSetTable.columnSideWeight}) as ${MonthlyMaxWeightEntity.columnTotalWeight},
        ${ExerciseSetTable.columnSetEndDateTime},
        CAST(strftime('%Y', ${ExerciseSetTable.columnSetEndDateTime} / 1000, 'unixepoch', 'localtime') AS INTEGER) as ${MonthlyMaxWeightEntity.columnYear},
        CAST(ltrim(strftime('%m', ${ExerciseSetTable.columnSetEndDateTime} / 1000, 'unixepoch', 'localtime'), "0") AS INTEGER) as ${MonthlyMaxWeightEntity.columnMonth}
      FROM ${ExerciseSetTable.name} 
      WHERE ${ExerciseSetTable.columnExerciseId} = $exerciseId
      GROUP BY ${MonthlyMaxWeightEntity.columnYear}, ${MonthlyMaxWeightEntity.columnMonth}
      """);

      final results = <MonthlyMaxWeightEntity>[];
      for (final map in maps) {
        results.add(MonthlyMaxWeightEntity.fromMap(map));
      }

      return results;
    } on Exception catch (e) {
      Log.e(
          tag,
          "Cannot getMaxWeightMonthlyHistory with exercise_id '$exerciseId'",
          e);
      return [];
    }
  }

  Future<int> _getLastSetNum(
    int workoutId,
    int exerciseId,
  ) async {
    final lastSetNumResults = await database.query(
      ExerciseSetTable.name,
      columns: [ExerciseSetTable.columnSetNum],
      where:
          "${ExerciseSetTable.columnWorkoutId} = ? AND ${ExerciseSetTable.columnExerciseId} = ?",
      whereArgs: [workoutId, exerciseId],
      orderBy: "${ExerciseSetTable.columnSetNum} DESC",
      limit: 1,
    );

    if (lastSetNumResults.isEmpty) {
      return -1;
    }

    return lastSetNumResults[0][ExerciseSetTable.columnSetNum] as int;
  }
}

class ExerciseSetEntityFilter implements DaoFilter {
  ExerciseSetEntityFilter({
    this.workoutIds = const [],
    this.workoutId,
    this.exerciseIds = const [],
    this.exerciseId,
    this.setNum,
  });

  List<int> workoutIds;
  int? workoutId;
  List<int> exerciseIds;
  int? exerciseId;
  int? setNum;

  @override
  String? toWhereClause() {
    final where = <String>[];
    if (workoutIds.isNotEmpty) {
      final args = workoutIds.join(",");
      where.add("${ExerciseSetTable.columnWorkoutId} in ($args)");
    }
    if (workoutId != null) {
      where.add("${ExerciseSetTable.columnWorkoutId} = $workoutId");
    }
    if (exerciseIds.isNotEmpty) {
      final args = exerciseIds.join(",");
      where.add("${ExerciseSetTable.columnExerciseId} in ($args)");
    }
    if (exerciseId != null) {
      where.add("${ExerciseSetTable.columnExerciseId} = $exerciseId");
    }
    if (setNum != null) {
      where.add("${ExerciseSetTable.columnSetNum} = $setNum");
    }

    if (where.isEmpty) {
      return null;
    }

    return where.join(" AND ");
  }
}
