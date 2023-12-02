import '../model/workout_detail_entity.dart';
import '../schema.dart';
import 'dao_filter.dart';
import 'simple_dao.dart';

class WorkoutDetailDao
    extends SimpleDao<WorkoutDetailEntity, WorkoutDetailEntityFilter> {
  static const _tag = "WorkoutDetailDao";

  @override
  String get tag => _tag;

  @override
  String get tableName => WorkoutDetailTable.name;

  @override
  WorkoutDetailEntity createEntityFromMap(Map<String, dynamic> map) =>
      WorkoutDetailEntity.fromMap(map);

  @override
  WorkoutDetailEntityFilter createUpdateFilter(WorkoutDetailEntity entity) {
    throw UnimplementedError();
  }
}

class WorkoutDetailEntityFilter extends DaoFilter {
  WorkoutDetailEntityFilter({
    this.workoutIds = const [],
    this.workoutId,
    this.exerciseIds = const [],
    this.exerciseId,
  });

  List<int> workoutIds;
  int? workoutId;
  List<int> exerciseIds;
  int? exerciseId;

  @override
  String? toWhereClause() {
    final where = <String>[];
    if (workoutIds.isNotEmpty) {
      final args = workoutIds.join(",");
      where.add("${WorkoutDetailTable.columnWorkoutId} in ($args)");
    }
    if (workoutId != null) {
      where.add("${WorkoutDetailTable.columnWorkoutId} = $workoutId");
    }
    if (exerciseIds.isNotEmpty) {
      final args = exerciseIds.join(",");
      where.add("${WorkoutDetailTable.columnExerciseId} in ($args)");
    }
    if (exerciseId != null) {
      where.add("${WorkoutDetailTable.columnExerciseId} = $exerciseId");
    }

    if (where.isEmpty) {
      return null;
    }

    return where.join(" AND ");
  }
}
