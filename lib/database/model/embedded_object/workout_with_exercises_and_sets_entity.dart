import '../base_entity.dart';
import '../exercise_entity.dart';
import '../workout_entity.dart';
import 'exercise_with_sets_entity.dart';

class WorkoutWithExercisesAndSetsEntity extends BaseEntity {
  WorkoutWithExercisesAndSetsEntity({
    required this.workoutEntity,
    required this.exerciseWithSetsEntityMap,
  });

  final WorkoutEntity workoutEntity;
  final Map<ExerciseEntity, ExerciseWithSetsEntity> exerciseWithSetsEntityMap;

  @override
  Map<String, dynamic> toMap() => {};
}
