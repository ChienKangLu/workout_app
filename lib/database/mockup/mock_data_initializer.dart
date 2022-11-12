import '../../util/log_util.dart';
import '../dao/dao_provider_mixin.dart';
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

  Future<bool> _initWorkoutTable() async {
    for (final workoutEntity in MockDataProvider.instance.workoutEntities) {
      await workoutDao.add(workoutEntity);
    }

    final result = await workoutDao.findAll();
    Log.d(_tag, "init workout ${result.toString()}");
    return result.isNotEmpty;
  }

  Future<bool> _initExerciseTable() async {
    for (final exerciseEntity in MockDataProvider.instance.exerciseEntities) {
      await exerciseDao.add(exerciseEntity);
    }

    final result = await exerciseDao.findAll();
    Log.d(_tag, "init exercise ${result.toString()}");
    return result.isNotEmpty;
  }

  Future<bool> _initWorkoutDetailTable() async {
    for (final workoutDetailEntity in MockDataProvider.instance.workoutDetailEntities) {
      await workoutDetailDao.add(workoutDetailEntity);
    }

    final result = await workoutDetailDao.findAll();
    Log.d(_tag, "init workout_detail ${result.toString()}");
    return result.isNotEmpty;
  }

  Future<bool> _initWeightTrainingSetTable() async {
    for (final weightTrainingSetEntity in MockDataProvider.instance.weightTrainingSetEntities) {
      await weightTrainingSetDao.add(weightTrainingSetEntity);
    }

    final result = await weightTrainingSetDao.findAll();
    Log.d(_tag, "init weight_training_set ${result.toString()}");
    return result.isNotEmpty;
  }

  Future<bool> _initRunningSetTable() async {
    for (final runningSetEntity in MockDataProvider.instance.runningSetEntities) {
      await runningSetDao.add(runningSetEntity);
    }

    final result = await runningSetDao.findAll();
    Log.d(_tag, "init running_set ${result.toString()}");
    return result.isNotEmpty;
  }
}
