import '../database/dao/composed_workout_dao.dart';
import '../database/dao/dao_provider_mixin.dart';
import '../database/dao/dao_result.dart';
import '../database/dao/exercise_set_dao.dart';
import '../database/dao/workout_dao.dart';
import '../database/dao/workout_detail_dao.dart';
import '../database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import '../database/model/workout_entity.dart';
import 'conversion.dart';
import '../model/result.dart';
import '../model/workout.dart';
import 'factory/workout_factory.dart';

class WorkoutRepository with DaoProviderMixin {
  Future<Result<int>> createWorkout() async {
    final DaoResult<int> daoResult = await workoutDao.add(
      WorkoutEntity.create(
        createDateTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    return daoResult.asResult();
  }

  Future<Result<bool>> deleteWorkouts(List<int> workoutIds) async {
    DaoResult<bool> daoResult;
    daoResult = await exerciseSetDao.delete(ExerciseSetEntityFilter(
      workoutIds: workoutIds,
    ));

    if (daoResult is DaoError<bool>) {
      return daoResult.asResult();
    }

    daoResult = await workoutDetailDao.delete(WorkoutDetailEntityFilter(
      workoutIds: workoutIds,
    ));

    if (daoResult is DaoError<bool>) {
      return daoResult.asResult();
    }

    daoResult = await workoutDao.delete(WorkoutEntityFilter(
      ids: workoutIds,
    ));

    return daoResult.asResult();
  }

  Future<Result<bool>> updateWorkout(Workout workout) async {
    final DaoResult<bool> daoResult =
        await workoutDao.update(workout.asEntity());
    return daoResult.asResult();
  }

  Future<Result<List<Workout>>> getWorkouts({
    List<int> workoutIds = const [],
  }) async {
    final filter = ComposedWorkoutFilter(
      workoutIds: workoutIds,
    );

    final DaoResult<List<WorkoutWithExercisesAndSetsEntity>> daoResult =
        await composedWorkoutDao.findByFilter(filter);

    return daoResult.asResult(
      convert: (data) => WorkoutFactory.createWorkouts(data),
    );
  }
}
