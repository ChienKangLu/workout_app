class WeightTrainingSetEntity {
  WeightTrainingSetEntity(
    this.recordId,
    this.exerciseTypeId,
    this.set,
    this.baseWeight,
    this.sideWeight,
    this.repetition,
    this.endTime,
  );

  final int recordId;
  final int exerciseTypeId;
  final int set;
  final double baseWeight;
  final double sideWeight;
  final int repetition;
  final int endTime;
}
