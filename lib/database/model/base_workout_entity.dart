import 'base_entity.dart';

abstract class WorkoutEntity extends BaseEntity {
  WorkoutEntity({
    required this.workoutRecordId,
    required this.exerciseTypeId,
    required this.setNum,
  });

  final int workoutRecordId;
  final int exerciseTypeId;
  final int setNum;
}
