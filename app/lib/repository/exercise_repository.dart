import '../database/dao/dao_provider_mixin.dart';
import '../database/dao/dao_result.dart';
import '../database/dao/exercise_dao.dart';
import '../database/dao/exercise_set_dao.dart';
import '../database/dao/workout_detail_dao.dart';
import '../database/model/exercise_entity.dart';
import '../database/model/embedded_object/exercise_statistic_entity.dart';
import '../database/model/exercise_set_entity.dart';
import '../database/model/workout_detail_entity.dart';
import '../model/exercise.dart';
import '../model/exercise_statistic.dart';
import '../model/result.dart';
import 'factory/exercise_factory.dart';
import 'factory/exercise_statistic_factory.dart';

class ExerciseRepository with DaoProviderMixin {
  Future<Result<Exercise?>> getExercise(int exerciseId) async {
    final DaoResult<List<ExerciseEntity>> daoResult =
        await exerciseDao.findByFilter(
      ExerciseEntityFilter(id: exerciseId),
    );

    return daoResult.asResult(convert: (data) {
      if (data.isEmpty) {
        return null;
      }

      return ExerciseFactory.createExercise(data.first);
    });
  }

  Future<Result<List<Exercise>>> getExercises() async {
    final DaoResult<List<ExerciseEntity>> daoResult =
        await exerciseDao.findByFilter(null);

    return daoResult.asResult(
      convert: (data) => data
          .map(
            (entity) => ExerciseFactory.createExercise(entity),
          )
          .toList(),
    );
  }

  Future<Result<int>> createExercise(String name) async {
    final DaoResult<int> daoResult = await exerciseDao.add(
      ExerciseEntity.create(
        name: name,
      ),
    );

    return daoResult.asResult();
  }

  Future<Result<int>> addExercise(int workoutId, int exerciseId) async {
    final DaoResult<int> daoResult =
        await workoutDetailDao.add(WorkoutDetailEntity(
      workoutId: workoutId,
      exerciseId: exerciseId,
      createDateTime: DateTime.now().millisecondsSinceEpoch,
    ));

    return daoResult.asResult();
  }

  Future<Result<bool>> removeExerciseFromWorkout(
    int workoutId,
    int exerciseId,
  ) async {
    DaoResult<bool> daoResult;
    daoResult = await exerciseSetDao.delete(ExerciseSetEntityFilter(
      workoutId: workoutId,
      exerciseId: exerciseId,
    ));

    if (daoResult is DaoError<bool>) {
      return daoResult.asResult();
    }

    daoResult = await workoutDetailDao.delete(WorkoutDetailEntityFilter(
      workoutId: workoutId,
      exerciseId: exerciseId,
    ));

    return daoResult.asResult();
  }

  Future<Result<bool>> removeExercises(List<int> exerciseIds) async {
    DaoResult<bool> daoResult;
    daoResult = await exerciseSetDao.delete(ExerciseSetEntityFilter(
      exerciseIds: exerciseIds,
    ));

    if (daoResult is DaoError<bool>) {
      return daoResult.asResult();
    }

    daoResult = await workoutDetailDao.delete(WorkoutDetailEntityFilter(
      exerciseIds: exerciseIds,
    ));

    if (daoResult is DaoError<bool>) {
      return daoResult.asResult();
    }

    await exerciseDao.delete(ExerciseEntityFilter(ids: exerciseIds));

    return daoResult.asResult();
  }

  Future<Result<bool>> updateExercise({
    required int exerciseId,
    required String name,
  }) async {
    final DaoResult<bool> daoResult = await exerciseDao.update(
      ExerciseEntity.update(
        exerciseId: exerciseId,
        name: name,
      ),
    );

    return daoResult.asResult();
  }

  Future<Result<int>> addExerciseSet({
    required int workoutId,
    required int exerciseId,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final DaoResult<int> daoResult =
        await exerciseSetDao.add(ExerciseSetEntity.create(
      workoutId: workoutId,
      exerciseId: exerciseId,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
      endDateTime: DateTime.now().millisecondsSinceEpoch,
    ));

    return daoResult.asResult();
  }

  Future<Result<bool>> updateExerciseSet({
    required int workoutId,
    required int exerciseId,
    required int setNum,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final DaoResult<bool> daoResult = await exerciseSetDao.update(
      ExerciseSetEntity.update(
        workoutId: workoutId,
        exerciseId: exerciseId,
        setNum: setNum,
        baseWeight: baseWeight,
        sideWeight: sideWeight,
        repetition: repetition,
      ),
    );

    return daoResult.asResult();
  }

  Future<Result<bool>> removeExerciseSet({
    required int workoutId,
    required int exerciseId,
    required int setNum,
  }) async {
    final DaoResult<bool> daoResult = await exerciseSetDao.delete(
      ExerciseSetEntityFilter(
        workoutId: workoutId,
        exerciseId: exerciseId,
        setNum: setNum,
      ),
    );

    return daoResult.asResult();
  }

  Future<Result<ExerciseStatistic>> getStatistic(int exerciseId) async {
    final DaoResult<ExerciseStatisticEntity> daoResult =
        await exerciseSetDao.getStatistic(exerciseId);

    return daoResult.asResult(
      convert: (data) => ExerciseStatisticFactory.createExerciseStatistic(data),
    );
  }
}
