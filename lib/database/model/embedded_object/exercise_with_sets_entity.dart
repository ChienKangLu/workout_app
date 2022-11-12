import '../base_entity.dart';
import '../exercise_entity.dart';
import '../exercise_set_entity.dart';

abstract class ExerciseWithSetsEntity<T extends ExerciseSetEntity>
    extends BaseEntity {
  ExerciseWithSetsEntity({
    required this.exerciseEntity,
    required this.exerciseSetEntities,
  });

  final ExerciseEntity exerciseEntity;
  final List<T> exerciseSetEntities;

  @override
  Map<String, dynamic> toMap() => {};
}