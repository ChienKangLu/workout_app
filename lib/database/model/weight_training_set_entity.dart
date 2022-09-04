class WeightTrainingSetEntity {
  WeightTrainingSetEntity(
    this.recordId,
    this.exerciseId,
    this.set,
    this.baseWeight,
    this.sideWeight,
    this.repetition,
    this.endTime,
  );

  final int recordId;
  final int exerciseId;
  final int set;
  final double baseWeight;
  final double sideWeight;
  final int repetition;
  final int endTime;
}
