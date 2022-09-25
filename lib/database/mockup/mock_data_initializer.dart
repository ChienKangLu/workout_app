import '../../util/log_util.dart';
import '../dao/exercise_dao.dart';
import '../dao/running_dao.dart';
import '../dao/weight_training_dao.dart';
import '../dao/workout_record_dao.dart';
import '../workout_database.dart';
import 'mock_data_provider.dart';

class MockDataInitializer {
  static const _tag = "MockDataInitializer";

  WorkoutDatabase get _db => WorkoutDatabase.instance;
  ExerciseDao get exerciseDao => _db.exerciseDao;
  WorkoutRecordDao get workoutRecordDao => _db.workoutRecordDao;
  WeightTrainingDao get weightTrainingDao => _db.weightTrainingDao;
  RunningDao get runningDao => _db.runningDao;

  Future<void> initTestData() async {
    await _initExerciseTable();
    await _initWorkoutRecordTable();
    await _initWeightTrainingTable();
    await _initRunningTable();
  }

  Future<bool> _initExerciseTable() async {
    final exerciseEntities = MockDataProvider.instance.exerciseEntities;
    for (final exerciseEntity in exerciseEntities) {
      await exerciseDao.insertExercise(exerciseEntity);
    }

    final result = await exerciseDao.getExerciseEntities();
    Log.d(_tag, "init exercise ${result.toString()}");
    return result.isNotEmpty;
  }

  Future<bool> _initWorkoutRecordTable() async {
    final workoutRecordEntities =
        MockDataProvider.instance.workoutRecordEntities;
    for (final workoutRecordEntity in workoutRecordEntities) {
      await workoutRecordDao.insertWorkoutRecord(workoutRecordEntity);
    }

    final result = await workoutRecordDao.getWorkoutRecordEntities();
    Log.d(_tag, "init workout_record ${result.toString()}");
    return result.isNotEmpty;
  }

  Future<bool> _initWeightTrainingTable() async {
    final weightTrainingEntities =
        MockDataProvider.instance.weightTrainingEntities;
    for (final weightTrainingEntity in weightTrainingEntities) {
      await weightTrainingDao.insertWeightTraining(weightTrainingEntity);
    }

    final result = await weightTrainingDao.getWeightTrainingEntities();
    Log.d(_tag, "init weight_training ${result.toString()}");
    return result.isNotEmpty;
  }

  Future<bool> _initRunningTable() async {
    final runningEntities = MockDataProvider.instance.runningEntities;
    for (final weightTrainingEntity in runningEntities) {
      await runningDao.insertRunning(weightTrainingEntity);
    }

    final result = await runningDao.getRunningEntities();
    Log.d(_tag, "init running ${result.toString()}");
    return result.isNotEmpty;
  }
}
