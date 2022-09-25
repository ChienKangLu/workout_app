import '../running_entity.dart';
import 'workout_with_exercise_entity.dart';

class RunningWithExerciseEntity
    extends WorkoutWithExerciseEntity<RunningEntity> {
  RunningWithExerciseEntity.fromMap(Map<String, dynamic> map)
      : super.fromMap(map, RunningEntity.fromMap(map));
}
