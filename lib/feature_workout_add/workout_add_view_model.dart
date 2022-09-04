import '../model/workout.dart';
import '../repository/record_repository.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_type_repository.dart';

class WorkoutAddViewModel {
  final WorkoutTypeRepository _workoutTypeRepository =
      RepositoryManager.instance.workoutRepository;
  final RecordRepository _recordRepository =
      RepositoryManager.instance.recordRepository;

  Future<List<WorkoutType>> _getWorkoutTypes() => _workoutTypeRepository.workoutTypes;

  Future<WorkoutAddUiState> get workoutAddUiState async {
    final workoutTypes = await _getWorkoutTypes();
    return WorkoutAddUiState(
      workoutCategories:
          workoutTypes.map((type) => WorkoutCategory.fromType(type)).toList(),
    );
  }

  Future<int> createRecord(WorkoutCategory category) async {
    return await _recordRepository.addRecord(category.type);
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
