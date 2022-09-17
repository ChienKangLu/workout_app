enum WorkoutTypeEntity {
  weightTraining(_weightTrainingId),
  running(_runningId);

  static const int _weightTrainingId = 0;
  static const int _runningId = 1;

  const WorkoutTypeEntity(this.id);

  final int id;

  static WorkoutTypeEntity fromId(int id) {
    return values.firstWhere(
          (type) => type.id == id,
      orElse: () => throw Exception("id is not supported"),
    );
  }
}