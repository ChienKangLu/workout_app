import '../weight_training_entity.dart';
import 'workout_with_exercise_entity.dart';

class WeightTrainingWithExerciseEntity
    extends WorkoutWithExerciseEntity<WeightTrainingEntity> {
  WeightTrainingWithExerciseEntity.fromMap(Map<String, dynamic> map)
      : super.fromMap(map, WeightTrainingEntity.fromMap(map));
}
