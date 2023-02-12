import '../database/dao/composed_workout_dao.dart';
import '../database/dao/dao_provider_mixin.dart';
import '../database/dao/dao_result.dart';
import '../database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import '../database/model/workout_entity.dart';
import '../database/model/workout_type_entity.dart';
import '../model/conversion.dart';
import '../model/result.dart';
import '../model/workout.dart';
import 'factory/workout_factory.dart';
import 'factory/workout_type_entity_factory.dart';
import 'factory/workout_type_factory.dart';

class WorkoutRepository with DaoProviderMixin {
  Future<List<WorkoutType>> get workoutTypes async => WorkoutTypeEntity.values
      .map((entity) => WorkoutTypeFactory.fromEntity(entity))
      .toList(growable: false);

  Future<Result<int>> createWorkout(WorkoutType type) async {
    final workoutTypeEntity = WorkoutTypeEntityFactory.fromType(type);
    final DaoResult<int> daoResult = await workoutDao.add(
      WorkoutEntity.create(
        workoutTypeEntity: workoutTypeEntity,
        createDateTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    return daoResult.asResult();
  }

  Future<Result<bool>> deleteWorkouts(List<int> workoutIds) async {
    final DaoResult<bool> daoResult = await composedWorkoutDao.delete(
      workoutIds,
    );

    return daoResult.asResult();
  }

  Future<Result<bool>> updateWorkout(Workout workout) async {
    final DaoResult<bool> daoResult =
        await workoutDao.update(workout.asEntity());
    return daoResult.asResult();
  }

  Future<Result<List<Workout>>> getWorkouts({
    int? workoutId,
  }) async {
    final filter = WorkoutWithExercisesAndSetsEntityFilter(
      workoutId: workoutId,
    );

    final DaoResult<List<WorkoutWithExercisesAndSetsEntity>> daoResult =
        await composedWorkoutDao.findByFilter(filter);

    return daoResult.asResult(
      convert: (data) => WorkoutFactory.createWorkouts(data),
    );
  }
}
