import '../model/exercise_entity.dart';
import '../model/workout_type_entity.dart';
import '../schema.dart';
import 'simple_dao.dart';

class ExerciseDao extends SimpleDao<ExerciseEntity, ExerciseEntityFilter> {
  static const _tag = "ExerciseDao";

  @override
  String get tag => _tag;

  @override
  String get tableName => ExerciseTable.name;

  @override
  ExerciseEntity createEntityFromMap(Map<String, dynamic> map) =>
      ExerciseEntity.fromMap(map);

  @override
  ExerciseEntityFilter createUpdateFilter(ExerciseEntity entity) =>
      ExerciseEntityFilter(
        id: entity.exerciseId,
      );
}

class ExerciseEntityFilter extends SimpleEntityFilter {
  ExerciseEntityFilter({
    super.ids,
    super.id,
    this.workoutTypeEntity,
  });

  final WorkoutTypeEntity? workoutTypeEntity;

  @override
  String get columnId => ExerciseTable.columnExerciseId;

  @override
  String? toWhereClause() {
    final workoutTypeEntity = this.workoutTypeEntity;
    if (workoutTypeEntity != null) {
      return "${ExerciseTable.columnWorkoutTypeId} = ${workoutTypeEntity.id}";
    }

    return super.toWhereClause();
  }
}
