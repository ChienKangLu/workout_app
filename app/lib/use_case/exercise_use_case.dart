import '../model/exercise.dart';
import '../model/exercise_statistic.dart';
import '../model/result.dart';
import '../repository/exercise_repository.dart';
import '../repository/repository_manager.dart';
import '../util/log_util.dart';

class ExerciseUseCase {
  static const _tag = "ExerciseUseCase";

  final ExerciseRepository _exerciseRepository =
      RepositoryManager.instance.exerciseRepository;

  Future<Exercise?> getExercise(int exerciseId) async {
    final result = await _exerciseRepository.getExercise(exerciseId);
    if (result is Error<Exercise?>) {
      Log.e(
        _tag,
        "Error happens while get exercise with exercise ID: $exerciseId",
        result.exception,
      );
      return null;
    }

    return (result as Success<Exercise?>).data;
  }

  Future<List<Exercise>?> getExercises() async {
    final result = await _exerciseRepository.getExercises();
    if (result is Error<List<Exercise>>) {
      Log.e(_tag, "Error happens while get exercises", result.exception);
      return null;
    }

    return (result as Success<List<Exercise>>).data;
  }

  Future<int?> createExercise(String name) async {
    final result = await _exerciseRepository.createExercise(name);
    if (result is Error) {
      return null;
    }

    return (result as Success<int>).data;
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
      name: name,
    );
    if (result is Error) {
      return false;
    }

    return true;
  }

  Future<ExerciseStatistic?> getStatistic(int exerciseId) async {
    final result = await _exerciseRepository.getStatistic(exerciseId);
    if (result is Error<ExerciseStatistic>) {
      Log.e(
        _tag,
        "Error happens while getting statistic",
        result.exception,
      );
      return null;
    }

    return (result as Success<ExerciseStatistic>).data;
  }
}
