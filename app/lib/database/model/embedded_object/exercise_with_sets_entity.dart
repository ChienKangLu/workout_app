import '../base_entity.dart';
import '../exercise_entity.dart';
import '../exercise_set_entity.dart';

class ExerciseWithSetsEntity extends BaseEntity {
  ExerciseWithSetsEntity({
    required this.exerciseEntity,
    required this.exerciseSetEntities,
  });

  final ExerciseEntity exerciseEntity;
  final List<ExerciseSetEntity> exerciseSetEntities;

  @override
  Map<String, dynamic> toMap() => {
    "exerciseEntity": exerciseEntity,
    "exerciseSetEntities": exerciseSetEntities,
  };

  @override
  List<Object?> get props => [exerciseEntity, exerciseSetEntities];
}