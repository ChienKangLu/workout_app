import '../database/dao/dao_provider_mixin.dart';
import '../database/dao/dao_result.dart';
import '../database/dao/exercise_dao.dart';
import '../database/dao/weight_training_set_dao.dart';
import '../database/dao/workout_detail_dao.dart';
import '../database/model/exercise_entity.dart';
import '../database/model/weight_training_set_entity.dart';
import '../database/model/workout_detail_entity.dart';
import '../model/exercise.dart';
import '../model/result.dart';
import '../model/workout.dart';
import 'factory/exercise_factory.dart';
import 'factory/workout_type_entity_factory.dart';

class ExerciseRepository with DaoProviderMixin {
  Future<Result<List<Exercise>>> getExercises(WorkoutType type) async {
    final workoutTypeEntity = WorkoutTypeEntityFactory.fromType(type);
    final DaoResult<List<ExerciseEntity>> daoResult =
        await exerciseDao.findByFilter(
      ExerciseEntityFilter(
        workoutTypeEntity: workoutTypeEntity,
      ),
    );

    return daoResult.asResult(
      convert: (data) => data
          .map(
            (entity) => ExerciseFactory.createExercise(entity),
          )
          .toList(),
    );
  }

  Future<Result<int>> createExercise(WorkoutType type, String name) async {
    final workoutTypeEntity = WorkoutTypeEntityFactory.fromType(type);
    final DaoResult<int> daoResult = await exerciseDao.add(
      ExerciseEntity.create(
        name: name,
        workoutType: workoutTypeEntity,
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

  Future<Result<bool>> removeExercise(int workoutId, int exerciseId) async {
    DaoResult<bool> daoResult;
    daoResult = await weightTrainingSetDao.delete(WeightTrainingSetEntityFilter(
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

  Future<Result<int>> addWeightTrainingSet({
    required int workoutId,
    required int exerciseId,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final DaoResult<int> daoResult =
        await weightTrainingSetDao.add(WeightTrainingSetEntity.create(
      workoutId: workoutId,
      exerciseId: exerciseId,
      baseWeight: baseWeight,
      sideWeight: sideWeight,
      repetition: repetition,
      endDateTime: DateTime.now().millisecondsSinceEpoch,
    ));

    return daoResult.asResult();
  }

  Future<Result<bool>> updateWeightTrainingSet({
    required int workoutId,
    required int exerciseId,
    required int setNum,
    required double baseWeight,
    required double sideWeight,
    required int repetition,
  }) async {
    final DaoResult<bool> daoResult = await weightTrainingSetDao.update(
      WeightTrainingSetEntity.update(
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
}
