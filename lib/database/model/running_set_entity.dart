class RunningSetEntity {
  RunningSetEntity(
      this.recordId,
      this.exerciseTypeId,
      this.duration,
      this.distance
  );

  final int recordId;
  final int exerciseTypeId;
  final double duration;
  final double distance;
}