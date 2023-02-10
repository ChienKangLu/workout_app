import '../core_view/workout_category.dart';
import '../model/workout.dart';
import '../model/result.dart';
import '../repository/workout_repository.dart';
import '../repository/repository_manager.dart';

class WorkoutAddViewModel {
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;

  Future<List<WorkoutType>> _getWorkoutTypes() =>
      _workoutRepository.workoutTypes;

  Future<WorkoutAddUiState> get workoutAddUiState async {
    final workoutTypes = await _getWorkoutTypes();
    return WorkoutAddUiState(
      workoutCategories:
          workoutTypes.map((type) => WorkoutCategory.fromType(type)).toList(),
    );
  }

  Future<bool> createWorkout(WorkoutCategory category) async {
    final result = await _workoutRepository.createWorkout(category.type);
    if (result is Error) {
      return false;
    }

    return true;
  }
}

class WorkoutAddUiState {
  WorkoutAddUiState({required this.workoutCategories});

  final List<WorkoutCategory> workoutCategories;
}
