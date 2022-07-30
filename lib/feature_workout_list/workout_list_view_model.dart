import '../model/exercise.dart';
import '../model/unit.dart';
import '../model/workout.dart';

class WorkoutListViewModel {
  final List<Workout> _workouts = <Workout>[
    WeightTraining(name: "Weight training 1", exercises: [
      WeightTrainingExercise(
        name: "Bench press",
        sets: [
          WeightTrainingExerciseSet(baseWeight: 20, sideWeight: 15, unit: WeightUnit.kilogram, repetition: 5),
          WeightTrainingExerciseSet(baseWeight: 20, sideWeight: 15, unit: WeightUnit.kilogram, repetition: 5),
          WeightTrainingExerciseSet(baseWeight: 20, sideWeight: 20, unit: WeightUnit.kilogram, repetition: 5),
          WeightTrainingExerciseSet(baseWeight: 20, sideWeight: 20, unit: WeightUnit.kilogram, repetition: 2),
          WeightTrainingExerciseSet(baseWeight: 20, sideWeight: 17.5, unit: WeightUnit.kilogram, repetition: 5),
          WeightTrainingExerciseSet(baseWeight: 20, sideWeight: 17.5, unit: WeightUnit.kilogram, repetition: 5),
        ],
      ),
      WeightTrainingExercise(
        name: "Shoulder push",
        sets: [
          WeightTrainingExerciseSet(baseWeight: 0, sideWeight: 10, unit: WeightUnit.kilogram, repetition: 6),
          WeightTrainingExerciseSet(baseWeight: 0, sideWeight: 12.5, unit: WeightUnit.kilogram, repetition: 6),
          WeightTrainingExerciseSet(baseWeight: 0, sideWeight: 12.5, unit: WeightUnit.kilogram, repetition: 6),
        ],
      ),
      WeightTrainingExercise(
        name: "Low row",
        sets: [
          WeightTrainingExerciseSet(baseWeight: 25, sideWeight: 0, unit: WeightUnit.kilogram, repetition: 12),
          WeightTrainingExerciseSet(baseWeight: 25, sideWeight: 0, unit: WeightUnit.kilogram, repetition: 12),
          WeightTrainingExerciseSet(baseWeight: 25, sideWeight: 0, unit: WeightUnit.kilogram, repetition: 12),
        ],
      ),
    ]),
    Running(
      name: "Running 1",
      exercises: [
        RunningExercise(
          name: "Jog",
          sets: [
            RunningExerciseSet(distance: 2, unit: DistanceUnit.kilometer),
          ],
        ),
      ],
    ),
  ];

  WorkoutListUiState get workoutListState {
    return _toWorkoutListUiState(_workouts);
  }

  WorkoutListUiState _toWorkoutListUiState(List<Workout> workouts) {
    return WorkoutListUiState(
      workouts: workouts.map((workout) => _toWorkoutUiState(workout)).toList(),
    );
  }

  WorkoutUiState _toWorkoutUiState(Workout workout) {
    return WorkoutUiState(
      name: workout.name,
      exerciseThumbnailList: _toExerciseThumbnailListUiState( workout.exercises),
      onTap: () {
        // TODO: launch exercise page
      },
    );
  }

  ExerciseThumbnailListUiState _toExerciseThumbnailListUiState(List<Exercise> exercises) {
    return ExerciseThumbnailListUiState(
      exerciseThumbnails: exercises.map((exercise) => _toExerciseThumbnailUiState(exercise)).toList(),
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
    required this.name,
    required this.exerciseThumbnailList,
    required this.onTap,
  });

  final String name;
  final ExerciseThumbnailListUiState exerciseThumbnailList;
  final void Function() onTap;
}

class WorkoutListUiState {
  WorkoutListUiState({
    required this.workouts,
  });

  final List<WorkoutUiState> workouts;
}