class RunningSetDao {
  RunningSetDao(
      this.recordId,
      this.exerciseId,
      this.duration,
      this.distance
  );

  final int recordId;
  final int exerciseId;
  final double duration;
  final double distance;
}