import 'base_entity.dart';

abstract class ExerciseSetEntity extends BaseEntity {
  ExerciseSetEntity({
    required this.workoutId,
    required this.exerciseId,
    required this.setNum,
  });

  final int workoutId;
  final int exerciseId;
  final int setNum;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSetEntity &&
          runtimeType == other.runtimeType &&
          workoutId == other.workoutId &&
          exerciseId == other.exerciseId &&
          setNum == other.setNum;

  @override
  int get hashCode =>
      workoutId.hashCode ^
      exerciseId.hashCode ^
      setNum.hashCode;
}
