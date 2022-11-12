import '../weight_training_set_entity.dart';
import 'exercise_with_sets_entity.dart';

class ExerciseWithWeightTrainingSetsEntity
    extends ExerciseWithSetsEntity<WeightTrainingSetEntity> {
  ExerciseWithWeightTrainingSetsEntity({
    required super.exerciseEntity,
    required super.exerciseSetEntities,
  });
}