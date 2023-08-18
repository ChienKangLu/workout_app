import '../model/workout_entity.dart';
import '../schema.dart';
import 'simple_dao.dart';

class WorkoutDao extends SimpleDao<WorkoutEntity, WorkoutEntityFilter> {
  static const _tag = "WorkoutDao";

  @override
  String get tag => _tag;

  @override
  String get tableName => WorkoutTable.name;

  @override
  WorkoutEntity createEntityFromMap(Map<String, dynamic> map) =>
      WorkoutEntity.fromMap(map);

  @override
  WorkoutEntityFilter createUpdateFilter(WorkoutEntity entity) =>
      WorkoutEntityFilter(id: entity.workoutId);
}

class WorkoutEntityFilter extends SimpleEntityFilter {
  WorkoutEntityFilter({
    super.ids,
    super.id,
  });

  @override
  String get columnId => WorkoutTable.columnWorkoutId;
}
