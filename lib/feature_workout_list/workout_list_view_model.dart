import 'package:flutter/foundation.dart';

import '../core_view/workout_category.dart';
import '../core_view/workout_status.dart';
import '../model/exercise.dart';
import '../model/result.dart';
import '../model/workout.dart';
import '../repository/repository_manager.dart';
import '../repository/workout_repository.dart';

class WorkoutListViewModel extends ChangeNotifier {
  final WorkoutRepository _workoutRepository =
      RepositoryManager.instance.workoutRepository;

  Future<Result<List<Workout>>> get _workouts =>
      _workoutRepository.getWorkouts();

  Future<WorkoutListUiState> get workoutListState async {
    final result = await _workouts;
    return _toWorkoutListUiState(result);
  }

  WorkoutListUiState _toWorkoutListUiState(Result<List<Workout>> result) {
    if (result is Error) {
      return WorkoutListUiState(workouts: []);
    }

    return WorkoutListUiState(
      workouts: (result as Success<List<Workout>>)
          .data
          .map((workout) => _toWorkoutUiState(workout))
          .toList(),
    );
  }

  WorkoutUiState _toWorkoutUiState(Workout workout) {
    return WorkoutUiState(
      workoutId: workout.workoutId,
      number: workout.typeNum + 1,
      category: WorkoutCategory.fromType(workout.type),
      exerciseThumbnailList: _toExerciseThumbnailListUiState(workout.exercises),
      workoutStatus: WorkoutStatus.fromDateTime(
          workout.startDateTime, workout.endDateTime),
    );
  }

  ExerciseThumbnailListUiState _toExerciseThumbnailListUiState(
    List<Exercise> exercises,
  ) {
    return ExerciseThumbnailListUiState(
      exerciseThumbnails: exercises
          .map((exercise) => _toExerciseThumbnailUiState(exercise))
          .toList(),
    );
  }

  ExerciseThumbnailUiState _toExerciseThumbnailUiState(Exercise exercise) {
    return ExerciseThumbnailUiState(name: exercise.name);
  }
}

class ExerciseThumbnailUiState {
  ExerciseThumbnailUiState({required this.name});

  final String name;
}

class ExerciseThumbnailListUiState {
  ExerciseThumbnailListUiState({
    required this.exerciseThumbnails,
  });

  final List<ExerciseThumbnailUiState> exerciseThumbnails;
}

class WorkoutUiState {
  WorkoutUiState({
    required this.workoutId,
    required this.number,
    required this.category,
    required this.exerciseThumbnailList,
    required this.workoutStatus,
  });

  final int workoutId;
  final int number;
  final WorkoutCategory category;
  final ExerciseThumbnailListUiState exerciseThumbnailList;
  final WorkoutStatus workoutStatus;
}

class WorkoutListUiState {
  WorkoutListUiState({
    required this.workouts,
  });

  final List<WorkoutUiState> workouts;
}
