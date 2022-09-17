import '../model/workout.dart';
import '../repository/workout_repository.dart';
import '../repository/repository_manager.dart';

class WorkoutAddViewModel {
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;

  Future<List<WorkoutType>> _getWorkoutTypes() => _workoutRepository.workoutTypes;

  Future<WorkoutAddUiState> get workoutAddUiState async {
    final workoutTypes = await _getWorkoutTypes();
    return WorkoutAddUiState(
      workoutCategories:
          workoutTypes.map((type) => WorkoutCategory.fromType(type)).toList(),
    );
  }

  Future<int> createWorkout(WorkoutCategory category) async {
    return await _workoutRepository.createWorkout(category.type);
  }
}

enum WorkoutCategory {
  weightTraining(WorkoutType.weightTraining),
  running(WorkoutType.running);

  const WorkoutCategory(this.type);

  final WorkoutType type;

  static WorkoutCategory fromType(WorkoutType type) {
    return values.firstWhere(
      (category) => category.type == type,
      orElse: () => throw Exception("$type is not supported"),
    );
  }
}

class WorkoutAddUiState {
  WorkoutAddUiState({required this.workoutCategories});

  final List<WorkoutCategory> workoutCategories;
}
