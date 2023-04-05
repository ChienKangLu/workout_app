import '../model/weight_training_set_entity.dart';
import '../schema.dart';
import 'dao_filter.dart';
import 'dao_result.dart';
import 'simple_dao.dart';

class WeightTrainingSetDao
    extends SimpleDao<WeightTrainingSetEntity, WeightTrainingSetEntityFilter> {
  static const _tag = "WeightTrainingSetDao";
  static const _initSetNum = 1;

  @override
  String get tag => _tag;

  @override
  String get tableName => WeightTrainingSetTable.name;

  @override
  WeightTrainingSetEntity createEntityFromMap(Map<String, dynamic> map) =>
      WeightTrainingSetEntity.fromMap(map);

  @override
  WeightTrainingSetEntityFilter createUpdateFilter(
          WeightTrainingSetEntity entity) =>
      WeightTrainingSetEntityFilter(
        workoutId: entity.workoutId,
        exerciseId: entity.exerciseId,
        setNum: entity.setNum,
      );

  @override
  Future<DaoResult<int>> add(WeightTrainingSetEntity entity) async {
    final lastSetNum =
        await _getLastSetNum(entity.workoutId, entity.exerciseId);

    final int setNum;
    if (lastSetNum == -1) {
      setNum = _initSetNum;
    } else {
      setNum = lastSetNum + 1;
    }

    return super.add(
      WeightTrainingSetEntity(
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

  Future<int> _getLastSetNum(
    int workoutId,
    int exerciseId,
  ) async {
    final lastSetNumResults = await database.query(
      WeightTrainingSetTable.name,
      columns: [WeightTrainingSetTable.columnSetNum],
      where:
          "${WeightTrainingSetTable.columnWorkoutId} = ? AND ${WeightTrainingSetTable.columnExerciseId} = ?",
      whereArgs: [workoutId, exerciseId],
      orderBy: "${WeightTrainingSetTable.columnSetNum} DESC",
      limit: 1,
    );

    if (lastSetNumResults.isEmpty) {
      return -1;
    }

    return lastSetNumResults[0][WeightTrainingSetTable.columnSetNum] as int;
  }
}

class WeightTrainingSetEntityFilter implements DaoFilter {
  WeightTrainingSetEntityFilter({
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
      where.add("${WeightTrainingSetTable.columnWorkoutId} in ($args)");
    }
    if (workoutId != null) {
      where.add("${WeightTrainingSetTable.columnWorkoutId} = $workoutId");
    }
    if (exerciseIds.isNotEmpty) {
      final args = exerciseIds.join(",");
      where.add("${WeightTrainingSetTable.columnExerciseId} in ($args)");
    }
    if (exerciseId != null) {
      where.add("${WeightTrainingSetTable.columnExerciseId} = $exerciseId");
    }
    if (setNum != null) {
      where.add("${WeightTrainingSetTable.columnSetNum} = $setNum");
    }

    if (where.isEmpty) {
      return null;
    }

    return where.join(" AND ");
  }
}
