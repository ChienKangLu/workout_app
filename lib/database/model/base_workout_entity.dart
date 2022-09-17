import 'base_entity.dart';

abstract class BaseWorkoutEntity extends BaseEntity {
  BaseWorkoutEntity(
    this.workoutRecordId,
    this.exerciseTypeId,
    this.setNum,
  );

  final int workoutRecordId;
  final int exerciseTypeId;
  final int setNum;
}
