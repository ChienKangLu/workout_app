import '../model/exercise.dart';
import '../model/exercise_statistic.dart';
import '../model/result.dart';
import '../model/workout.dart';
import '../repository/exercise_repository.dart';
import '../repository/repository_manager.dart';
import '../util/log_util.dart';

class ExerciseUseCase {
  static const _tag = "ExerciseUseCase";

  final ExerciseRepository _exerciseRepository =
      RepositoryManager.instance.exerciseRepository;

  Future<List<Exercise>?> getExercises() async {
    final Result<List<Exercise>> result =
        await _exerciseRepository.getExercises(WorkoutType.weightTraining);
    if (result is Error<List<Exercise>>) {
      Log.e(_tag, "Error happens while get exercises", result.exception);
      return null;
    }

    return (result as Success<List<Exercise>>).data;
  }

  Future<bool> createExercise(String name) async {
    final result = await _exerciseRepository.createExercise(
        WorkoutType.weightTraining, name);
    if (result is Error) {
      return false;
    }

    return true;
  }

  Future<bool> removeExercises(List<int> exerciseIds) async {
    final result = await _exerciseRepository.removeExercises(exerciseIds);
    if (result is Error) {
      return false;
    }

    return true;
  }

  Future<bool> updateExercise({
    required int exerciseId,
    required String name,
  }) async {
    final result = await _exerciseRepository.updateExercise(
      exerciseId: exerciseId,
      workoutType: WorkoutType.weightTraining,
      name: name,
    );
    if (result is Error) {
      return false;
    }

    return true;
  }

  Future<ExerciseStatistic?> getExerciseStatistic(int exerciseId) async {
    final Result<ExerciseStatistic> result =
        await _exerciseRepository.getExerciseStatistic(exerciseId);
    if (result is Error<ExerciseStatistic>) {
      Log.e(
        _tag,
        "Error happens while get exercise statistic",
        result.exception,
      );
      return null;
    }

    return (result as Success<ExerciseStatistic>).data;
  }
}
