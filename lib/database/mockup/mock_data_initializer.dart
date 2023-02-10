import '../../util/log_util.dart';
import '../dao/dao_provider_mixin.dart';
import '../dao/dao_result.dart';
import 'mock_data_provider.dart';

class MockDataInitializer with DaoProviderMixin {
  static const _tag = "MockDataInitializer";

  Future<void> initTestData() async {
    await _initWorkoutTable();
    await _initExerciseTable();
    await _initWorkoutDetailTable();
    await _initWeightTrainingSetTable();
    await _initRunningSetTable();
  }

  Future<void> _initWorkoutTable() async {
    for (final workoutEntity in MockDataProvider.instance.workoutEntities) {
      await workoutDao.add(workoutEntity);
    }

    final DaoResult result = await workoutDao.findAll();
    _logResult(result, "workout");
  }

  Future<void> _initExerciseTable() async {
    for (final exerciseEntity in MockDataProvider.instance.exerciseEntities) {
      await exerciseDao.add(exerciseEntity);
    }

    final result = await exerciseDao.findAll();
    _logResult(result, "exercise");
  }

  Future<void> _initWorkoutDetailTable() async {
    for (final workoutDetailEntity in MockDataProvider.instance.workoutDetailEntities) {
      await workoutDetailDao.add(workoutDetailEntity);
    }

    final result = await workoutDetailDao.findAll();
    _logResult(result, "workout_detail");
  }

  Future<void> _initWeightTrainingSetTable() async {
    for (final weightTrainingSetEntity in MockDataProvider.instance.weightTrainingSetEntities) {
      await weightTrainingSetDao.add(weightTrainingSetEntity);
    }

    final result = await weightTrainingSetDao.findAll();
    _logResult(result, "weight_training_set");
  }

  Future<void> _initRunningSetTable() async {
    for (final runningSetEntity in MockDataProvider.instance.runningSetEntities) {
      await runningSetDao.add(runningSetEntity);
    }

    final result = await runningSetDao.findAll();
    _logResult(result, "running_set");
  }

  _logResult(DaoResult result, String tableName) {
    if (result is DaoSuccess) {
      Log.d(_tag, "init $tableName ${result.data.toString()}");
    } else if (result is DaoError) {
      Log.e(_tag, "fail to init $tableName, e = ${result.exception}");
    }
  }
}
